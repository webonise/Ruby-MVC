# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'surfer/version'

Gem::Specification.new do |spec|
  spec.name          = "surfer"
  spec.version       = Surfer::VERSION
  spec.authors       = ["Aditya Kamatar","Mohit Singh"]
  spec.email         = ["adityakamatar@gmail.com","cmohitsingh.chauhan@gmail.com"]
  spec.description   = "This is a Ruby-MVC Framework Which has all the necessary modules to build up a basic web application"
  spec.summary       = "Ruby-MVC Framework"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "erubis"

  spec.add_development_dependency "mysql"
  spec.add_development_dependency "dbi"
  spec.add_development_dependency "dbd-mysql"

  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "erubis"
  spec.add_runtime_dependency "mysql"
  spec.add_runtime_dependency "dbi"
  spec.add_runtime_dependency "dbd-mysql"

  
end
