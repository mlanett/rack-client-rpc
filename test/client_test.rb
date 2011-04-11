require File.expand_path( "../helper", __FILE__ )
require "rack/client"

# Uses minitest
# @see http://bfts.rubyforge.org/minitest/
# @see https://github.com/seattlerb/minitest

class Upcase < Rack::Rpc::Client
  self.rack_client = Rack::Client.new { run lambda { |env| [ 200, { 'Content-Type' => 'text/plain' }, env["PATH_INFO"].upcase ] } }
  get   "/foo", :name => "foos"
  post  "/bar", :name => "new_bar"
end

describe Rack::Rpc::Client do
  it "supports rpc-client get calls" do
    Upcase.new.foos.must_equal "/FOO"
  end
  it "supports rpc-client post calls" do
    Upcase.new.foos.must_equal "/NEW_BAR"
  end
end
