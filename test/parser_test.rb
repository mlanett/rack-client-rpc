require File.expand_path( "../helper", __FILE__ )
require "rack/client"

# Uses minitest
# @see http://bfts.rubyforge.org/minitest/
# @see https://github.com/seattlerb/minitest

describe Rack::Rpc::Parser do
  
  def it_parses( url, name, keys )
    it "parses #{url}" do
      Rack::Rpc::Parser.parse( url )[0].must_equal name
      Rack::Rpc::Parser.parse( url )[1].must_equal got_keys
    end
  end
  
  it_parses "http://google.com/q?search=:term", "google_q", ["term"]
  it_parses "/thing/:id/check", "thing_check", ["id"]
  
end
