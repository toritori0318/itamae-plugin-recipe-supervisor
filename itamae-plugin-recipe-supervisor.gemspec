# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/recipe/supervisor/version'

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-recipe-supervisor"
  spec.version       = Itamae::Plugin::Recipe::Supervisor::VERSION
  spec.authors       = ["toritori0318"]
  spec.email         = ["toritori0318@gmail.com"]
  spec.summary       = %q{Itamae resource plugin for supervisor.}
  spec.description   = %q{Itamae resource plugin for supervisor.}
  spec.homepage      = "https://github.com/toritori0318/itamae-plugin-recipe-supervisor"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
