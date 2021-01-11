# frozen_string_literal: true

module Hermes
  module Clients
    # Basic client for sending api requests
    class ClientClient < BaseClient
      class << self
        # HTTP GET request to the Hermes API to retrieve a client by id
        #
        # @param message [integer] client id
        # @return [Hash] client data
        def fetch(id)
          conn = api_connection api_url
          response = conn.get("#{api_url}/#{id}")

          return response.body if response.success?

          raise Hermes::Error.new(response.status, response.body)
        end

        # HTTP GET request to the Hermes API to retrieve a client by id
        #
        # @param message [integer] client id
        # @return [Array] client data
        def fetch_messages(id)
          conn = api_connection api_url
          response = conn.get("#{api_url}/#{id}/messages")

          return response.body if response.success?

          raise Hermes::Error.new(response.status, response.body)
        end

        private

        def api_url
          "#{base_url}/clients"
        end
      end
    end
  end
end
