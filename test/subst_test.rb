require File.expand_path( "../helper", __FILE__ )
require "rack/client"

# Uses minitest
# @see http://bfts.rubyforge.org/minitest/
# @see https://github.com/seattlerb/minitest

describe Rack::Rpc::Parser do
  it "works" do
    Rack::Rpc::Parser.substitute.must_equal true
  end
end

class WithParams < Rack::Rpc::Client
  self.rack_client = Rack::Client.new { run lambda { |env| [ 200, { 'Content-Type' => 'text/plain' }, env["PATH_INFO"] ] } }
  get   "/foo/:id"
  put   "/bar/:id"
end

describe Rack::Rpc::Client do
  it "supports rpc-client get calls" do
    WithParams.new.foo(1).must_equal "/foo/1"
  end
  it "supports rpc-client post calls" do
    WithParams.new.bar(1).must_equal "/bar/1"
  end
end
