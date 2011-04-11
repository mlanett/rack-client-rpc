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

class Upcase < Rack::Rpc::Client
  self.rack_client = Rack::Client.new { run lambda { |env| [ 200, { 'Content-Type' => 'text/plain' }, env["PATH_INFO"].upcase ] } }
  get   "/foo/:id"
  put   "/bar/:id"
end

describe Rack::Rpc::Client do
  it "supports rpc-client calls" do
    Upcase.new.foo(1).must_equal "/FOO/1"
    Upcase.new.bar(1).must_equal "/BAR/1"
  end
end
