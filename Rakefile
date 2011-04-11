require 'bundler'
Bundler::GemHelper.install_tasks

desc "run all tests"
task "test" do
  require File.expand_path( "../test/helper", __FILE__ )
  Dir.glob( "test/**/*_test.rb" ).each { |f| load f }
end
