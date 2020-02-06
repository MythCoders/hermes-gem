# frozen_string_literal: true

require_relative 'hermes/version'
require_relative 'hermes/error'
require_relative 'hermes/gateway'
require_relative 'hermes/mailbox'

module Hermes
  def self.version
    "Hermes API v#{Hermes::VERSION}"
  end
end
