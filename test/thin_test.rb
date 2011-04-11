require File.expand_path( "../helper", __FILE__ )
require "rack/client"
require "thin"

# Uses minitest
# @see http://bfts.rubyforge.org/minitest/
# @see https://github.com/seattlerb/minitest

SelfServer = Rack::Builder.app do
  map("/ab") { run lambda { |env| [ 200, { 'Content-Type' => 'text/plain' }, Time.now.to_s ] } }
end

class SelfClient < Rack::Client::Rpc::Client
  self.rack_client = Rack::Client.new { run Rack::Client::Handler::EmHttp.new("") }
  get   "http://localhost:3000/ab"
end

describe Rack::Client::Rpc do
  it "can be used to make requests to self using thin" do
    go do
      Thin::Server.start( "0.0.0.0", 3000, SelfServer )
      client = SelfClient.new
      a = client.ab
    end
  end
end
