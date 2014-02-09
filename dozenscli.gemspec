# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dozenscli/version'

Gem::Specification.new do |spec|
  spec.name          = "dozenscli"
  spec.version       = Dozenscli::VERSION
  spec.authors       = ["h-tane"]
  spec.email         = ["h-tane@nekojarashi.com"]
  spec.summary       = %q{Command Line Interface for Dozens.}
  spec.description   = %q{This package provides a command line interface to Dozens REST API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_dependency "thor", "~> 0.18"
  spec.add_dependency "inifile", "~> 2.0.2"
end
