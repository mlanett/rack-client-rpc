require "rack/client"

module Rack
  module Rpc
  
    class Client
    
      class << self
      
        # Usage: class X < Rack::Rpc::Client; self.rack_client = ...; end
        def rack_client=(c)
          @rack_client = c
        end
      
        def rack_client
          @rack_client ||= ::Rack::Client.new { run Rack::Client::Handler::NetHTTP }
        end
      
        def get(  url, options = nil ); define_http_method( :get,  url, options ); end
        def post( url, options = nil ); define_http_method( :post, url, options ); end
        def put(  url, options = nil ); define_http_method( :put,  url, options ); end
        
        protected
        
        def define_http_method( method, url, options )
          name, keys, uri = Parser.parse(url)
          as_name = options && options[:name] || name
          puts "defined #{as_name}(#{keys.join(',')}) => #{url}"
          define_method(as_name) do |*args|
            response = self.class.rack_client.send( method, url )
            status = response.status
            if ! (200...299).member? status then
              message = Rack::Utils::HTTP_STATUS_CODES[status]
              raise message ? IOError.new("#{status} #{message}") : IOError.new(status.to_s)
            end
            type = response.header["Content-Type"]
            response.body.first
          end
        end
        
      end # class
    
    end # Client
  
  end # Rpc
end # Rack
