# frozen_string_literal: true

require 'hermes/version'
require_relative 'hermes/meta'
require_relative 'hermes/client'
require 'hermes/railtie' if defined?(Rails)

module Hermes
  GET    = 'get'
  POST   = 'post'
  PUT    = 'put'
  PATCH  = 'patch'
  DELETE = 'delete'

  def self.version
    "Hermes API version #{Hermes::VERSION}"
  end

  def self.default_client
    # Delegate to the Railtie if it's there
    if defined?(Railtie)
      Railtie.instance.default_client
    else
      Client.new ENV['HERMES_API_KEY'], ENV['HERMES_API_SECRET']
    end
  end
end
