# frozen_string_literal: true

require_relative 'hermes/client'
require_relative 'hermes/version'

module Hermes
  def self.name
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
