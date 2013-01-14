$:.unshift File.expand_path('../lib', __FILE__)
require 'noveku/version'

Gem::Specification.new do |s|
  s.name                      = "noveku"
  s.version                   = Noveku::VERSION
  s.platform                  = Gem::Platform::RUBY
  s.authors                   = ["Novelys", "Kevin Soltysiak"]
  s.email                     = ["contact@novelys.com"]
  s.homepage                  = "http://github.com/novelys/noveku"
  s.summary                   = "Heroku shorcuts for commonly used commands at novelys"
  s.description               = "A set of heroku aliases meant to speed up heroku interaction when dealing with multilple heroku remotes."
  s.rubyforge_project         = s.name
  s.required_rubygems_version = ">= 1.3.6"
  s.files                     = `git ls-files`.split("\n")
  s.executables               << 'noveku'
  s.require_path              = 'lib'
  s.add_dependency('gomon')
end
