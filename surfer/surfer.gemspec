# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'surfer/version'

Gem::Specification.new do |spec|
  spec.name          = "surfer"
  spec.version       = Surfer::VERSION
  spec.authors       = ["AdityaKamatar"]
  spec.email         = ["aditya.kamatar@weboniselab.com"]
  spec.description   = "This is a Ruby-MVC Framework"
  spec.summary       = "Ruby-MVC"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "rack"
end
