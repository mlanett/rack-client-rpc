require "rack/client"

module Rack
  module Client
    module Rpc

      class Client

        class << self

          # Usage: class X < Rack::Client::Rpc::Client; self.rack_client = ...; end
          def rack_client=(c)
            @rack_client = c
          end

          def rack_client
            @rack_client ||= ::Rack::Client.new { run Rack::Client::Handler::NetHTTP }
          end

          def get(  pattern, options = nil ); define_http_method( :get,  pattern, options ); end
          def post( pattern, options = nil ); define_http_method( :post, pattern, options ); end
          def put(  pattern, options = nil ); define_http_method( :put,  pattern, options ); end

          protected

          def define_http_method( method, pattern, options )
            name, keys, uri = Parser.parse(pattern)
            as_name = options && options[:name] || name
            puts "defined #{as_name}(#{keys.join(',')}) => #{uri}"
            define_method(as_name) do |*args|
              url = Parser.substitute( pattern, keys, *args )
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
  end # Client
end # Rack
