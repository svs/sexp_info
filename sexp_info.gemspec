# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sexp_info/version'

Gem::Specification.new do |spec|
  spec.name          = "sexp_info"
  spec.version       = SEXP_VERSION
  spec.authors       = ["svs"]
  spec.email         = ["svs@svs.io"]
  spec.description   = %q{Peek under the hood of sexps}
  spec.summary       = %q{gracefully}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "active_support"
  spec.add_dependency "i18n"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-given"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "pry_debug"
end
