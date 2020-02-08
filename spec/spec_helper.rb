# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('..', __dir__)

require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
  add_filter 'vendor'
end

require 'active_support/core_ext/module'
require 'hermes'
require 'rspec'
require 'rspec/junklet'
require 'faraday'
require 'webmock'
require 'webmock/rspec'
require 'faker'
require 'mail'
require 'pry'
require 'securerandom'
require 'dotenv'

Dotenv.load

Dir[File.join(__dir__, 'support', '**', '*.rb')].sort.each { |file| require file }

RSpec.configure do |config|
  config.color = true
  config.order = :random
  config.example_status_persistence_file_path = 'spec/examples.txt'
  Kernel.srand config.seed

  config.mock_with :rspec do |mocks|
    # This option should be set when all dependencies are being loaded
    # before a spec run, as is the case in a typical spec helper. It will
    # cause any verifying double instantiation for a class that does not
    # exist to raise, protecting against incorrectly spelt names.
    mocks.verify_doubled_constant_names = true
  end
end
