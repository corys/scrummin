# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scrummin/version'

Gem::Specification.new do |spec|
  spec.name          = "scrummin"
  spec.version       = Scrummin::VERSION
  spec.authors       = ["Chris Thorn", "Sonhui Lamson"]
  spec.email         = ["oss@resdat.com"]
  spec.description   = "Simple tool for facilitating SCRUM meetings"
  spec.summary       = "Simple tool for facilitating SCRUM meetings"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13"
end
