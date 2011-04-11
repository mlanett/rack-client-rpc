# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/client/rpc/version"

Gem::Specification.new do |s|
  s.name        = "rack-client-rpc"
  s.version     = Rack::Client::Rpc::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mark Lanett"]
  s.email       = ["mark.lanett@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/rack-client-rpc"
  s.summary     = %q{Wraps Rack-Client calls in plain old Ruby methods}
  
  s.rubyforge_project = "rack-client-rpc"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  #.add_dependency "em-http-request"
  s.add_dependency "rack-client"
end
