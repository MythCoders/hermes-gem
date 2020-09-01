# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hermes/version'

Gem::Specification.new do |spec|
  spec.name          = 'hermes'
  spec.version       = Hermes::VERSION
  spec.date          = '2020-02-07'
  spec.authors       = ['Justin Adkins']
  spec.email         = ['justin.adkins@mythcoders.com']

  spec.summary       = 'Hermes API'
  spec.description   = 'The public API for Hermes'
  spec.homepage      = 'https://gitlab.com/mythcoders/hermes-gem'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)
  #
  # spec.metadata['allowed_push_host'] = 'https://gems.mythcoders.io'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'railties'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 3.9'
  spec.add_development_dependency 'rspec-junklet', '>= 2.2'
  spec.add_development_dependency 'rspec_junit_formatter'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock', '~> 3.8'

  spec.add_runtime_dependency 'activesupport', '>= 4.2.2'
  spec.add_runtime_dependency 'faraday', '>= 1.0'
  spec.add_runtime_dependency 'faraday_middleware'
  spec.add_runtime_dependency 'hashie', '>= 3.4.0'
  spec.add_runtime_dependency 'mail', '>= 2.5.4'
  spec.add_runtime_dependency 'mime-types'
end
