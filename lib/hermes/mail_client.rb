# frozen_string_literal: true

module Hermes
  # Basic client for sending api requests
  class MailClient < BaseClient
    class << self
      # HTTP POST request to the Hermes API to create a new message
      #
      # @param message [Hash] message data
      # @return [Boolean] if the request was successful
      def new_mail(message)
        conn = api_connection api_url
        response = conn.post { |req| req.body = JSON.dump(message) }

        return true if response.success?

        raise Hermes::Error.new(response.status, response.body)
      end

      private

      def api_url
        "#{base_url}messages"
      end
    end
  end
end
