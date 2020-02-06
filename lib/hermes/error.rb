# frozen_string_literal: true

module Hermes
  class Error < StandardError
    def initialize(status, message)
      @status = status
      @message = message
    end

    attr_reader :message, :status

    def to_s
      "HTTP #{status} - #{message}"
    end
  end
end
