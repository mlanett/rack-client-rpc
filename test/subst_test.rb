require File.expand_path( "../helper", __FILE__ )
require "rack/client"

# Uses minitest
# @see http://bfts.rubyforge.org/minitest/
# @see https://github.com/seattlerb/minitest

describe Rack::Rpc::Parser do
  
  class Upcase < Rack::Rpc::Client
    self.rack_client = Rack::Client.new { run lambda { |env| [ 200, { 'Content-Type' => 'text/plain' }, env["PATH_INFO"].upcase ] } }
    get   "/foo", :name => "foos"
    get   "/foo/:id"
    post  "/bar", :name => "new_bar"
    put   "/bar/:id"
  end
  
  it "supports Upcase calls" do
    Upcase.new.foos.must_equal "/FOO"
  end
  
end
