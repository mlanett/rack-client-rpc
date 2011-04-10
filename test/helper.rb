require "rubygems"
require "bundler"
Bundler.setup

["lib","test"].map { |d| File.expand_path("../../#{d}", __FILE__) }.each { |d| $:.push(d) unless $:.member?(d) }

require "minitest/autorun"
