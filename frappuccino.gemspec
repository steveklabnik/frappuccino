# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'frppuccino/version'

Gem::Specification.new do |spec|
  spec.name          = "frppuccino"
  spec.version       = Frppuccino::VERSION
  spec.authors       = ["Steve Klabnik"]
  spec.email         = ["steve@steveklabnik.com"]
  spec.description   = %q{A library to do Functional Reactive Programming in Ruby.}
  spec.summary       = %q{Functional Reactive Programming in Ruby.}
  spec.homepage      = "https://github.com/steveklabnik/frppuccino"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
