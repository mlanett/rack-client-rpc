source "http://rubygems.org"

# Specify your gem's dependencies in rack-rpc.gemspec
gemspec

gem "em-http-request", :git => "git://github.com/igrigorik/em-http-request.git"

group :development, :test do
  gem "minitest"
  gem "ruby-debug19" if RUBY_VERSION =~ /^1\.9/
  gem "thin"
end
