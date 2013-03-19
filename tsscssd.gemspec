# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tsscssd/version'

Gem::Specification.new do |spec|
  spec.name          = "tsscssd"
  spec.version       = Tsscssd::VERSION
  spec.authors       = ["Tyler Scott"]
  spec.email         = ["scottt2@uw.edu"]
  spec.description   = %q{A stupid simple automated CSS styleguide based on your comments.}
  spec.summary       = %q{Mo' CSS? No problems!}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ['tsscssd']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
