require File.expand_path( "../helper", __FILE__ )
require "rack/client"

# Uses minitest
# @see http://bfts.rubyforge.org/minitest/
# @see https://github.com/seattlerb/minitest

describe Rack::Rpc::Parser do
  it "can substitute parameters into the url pattern" do
    Rack::Rpc::Parser.substitute( "/foo/:id", ["id"], 1 ).must_equal "/foo/1"
    Rack::Rpc::Parser.substitute( "/foo/:id/edit", ["id"], 1 ).must_equal "/foo/1/edit"
    Rack::Rpc::Parser.substitute( "/bar/:pid/:id", ["pid","id"], 1, 2 ).must_equal "/bar/1/2"
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
