require "uri"

module Rack
  module Rpc
    class Parser
      
      def self.parse( url )
        u = URI.parse(url)
        name = []
        keys = []
        u.component.each do |c|
          next if c == :port
          p = u.send(c)
          next if p.nil? || p.size == 0
          pname, pkeys = parse_component( c, p )
          name << pname if pname.size > 0
          keys += pkeys
        end
        [ name.join("_"), keys, u ]
      end
      
      def self.parse_component( component, pattern )
        name = ""
        keys = []
        
        # extract :id from /foo/:id/bar
        pattern = pattern.to_s.gsub( /(:\w+)/ ) { |match| keys << $1[1..-1]; '' }
        
        case component
        when :scheme
          # dump "http"
          name = pattern if pattern != "http"
        when :host
          # dump ".com"
          name = pattern.gsub( /\.com/, '' ).gsub( /\./, '_' )
        when :userinfo
          # ignore
        when :path
          # drop terminal / and =
          # convert / or // into _
          name = pattern.gsub( /^\/|\/$|=$/, '' ).gsub( /\/+/, '_' )
        when :query, :fragment
          # do not contribute to name
        else
          # ignore
        end
        
        # sanitize non-alphanumeric characters, keeping only "_"
        name = name.gsub( /[^0-9a-zA-Z_]/, '' ).gsub( /_+/, '_' )
        
        [ name, keys ]
      end # parse_component
      
      # url has the form google.com/q?search=:term
      # params has the form ["term"]
      def substitute( url, keys, *args )
        if keys.size != args.size then
          raise ArgumentError, "wrong number of arguments (#{args.size} for #{keys.size})"
        end
        zip = keys.zip(args)
      end
      
    end # Parser
  end # Rpc
end # Rack
