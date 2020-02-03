# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hermes/version'

Gem::Specification.new do |spec|
  spec.name          = 'hermes'
  spec.version       = Hermes::VERSION
  spec.date          = '2020-02-02'
  spec.authors       = ['Justin Adkins']
  spec.email         = ['justin.adkins@mythcoders.com']

  spec.summary       = 'Hermes API'
  spec.description   = 'The public API for Hermes'
  spec.homepage      = 'https://gitlab.com/mythcoders/hermes-gem'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'railties'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 3.2'
  spec.add_development_dependency 'rspec-junklet', '>= 2.0'

  spec.add_runtime_dependency 'faraday', '~> 0.11'
  spec.add_runtime_dependency 'faraday_middleware'
  spec.add_runtime_dependency 'hashie', '>= 3.4.0'
  spec.add_runtime_dependency 'mime-types'
end
