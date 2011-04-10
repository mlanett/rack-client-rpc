# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack-rpc/version"

Gem::Specification.new do |s|
  s.name        = "rack-rpc"
  s.version     = Rack::Rpc::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mark Lanett"]
  s.email       = ["mark.lanett@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/rack-rpc"
  s.summary     = %q{Wraps Rack-Client calls in plain old Ruby methods}
  
  s.rubyforge_project = "rack-rpc"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "rack-client"
end
