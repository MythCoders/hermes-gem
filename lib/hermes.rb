# frozen_string_literal: true

require_relative 'hermes/version'

module Hermes
  def self.version
    "Hermes API v#{Hermes::VERSION}"
  end
end
