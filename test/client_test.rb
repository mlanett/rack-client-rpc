require File.expand_path( "../helper", __FILE__ )
require "rack/client"

# Uses minitest
# @see http://bfts.rubyforge.org/minitest/
# @see https://github.com/seattlerb/minitest

class Simple < Rack::Client::Rpc::Client
  self.rack_client = Rack::Client.new { run lambda { |env| [ 200, { 'Content-Type' => 'text/plain' }, env["PATH_INFO"] ] } }
  get   "/foo", :name => "foos"
  post  "/bar", :name => "new_bar"
end

describe Rack::Client::Rpc::Client do
  it "supports rpc-client get calls" do
    Simple.new.foos.must_equal "/foo"
  end
  it "supports rpc-client post calls" do
    Simple.new.new_bar.must_equal "/bar"
  end
end
