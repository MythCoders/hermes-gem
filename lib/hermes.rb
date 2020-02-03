# frozen_string_literal: true

require_relative 'hermes/version'

module Hermes
  def self.name
    "Hermes API version #{Hermes::VERSION}"
  end
end
