require File.expand_path( "../helper", __FILE__ )
require "rack/client"

# Uses minitest
# @see http://bfts.rubyforge.org/minitest/
# @see https://github.com/seattlerb/minitest

def it_parses( url, name, keys )
  it "parses #{url}" do
    Rack::Client::Rpc::Parser.parse( url )[0].must_equal name
    Rack::Client::Rpc::Parser.parse( url )[1].must_equal keys
  end
end

describe Rack::Client::Rpc::Parser do
  it_parses "http://google.com/q?search=:term", "google_q", ["term"]
  it_parses "http://localhost/check/:id/now", "check_now", ["id"]
  it_parses "/thing/:id/check", "thing_check", ["id"]
end
