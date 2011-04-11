require "rubygems"
require "bundler"
Bundler.setup

["lib","test"].map { |d| File.expand_path("../../#{d}", __FILE__) }.each { |d| $:.push(d) unless $:.member?(d) }

require "rack-rpc"
require "minitest/autorun"

# Stuffage

module URI
  class Generic
    def inspect
      self.component.inject({}) { |a,c| t = self.send(c); a[c] = t if t != nil; a }.to_json
    end
  end
end

def go( &block )
  EventMachine.run do
    Fiber.new do
      yield
      EM.stop
    end.resume
  end
end
