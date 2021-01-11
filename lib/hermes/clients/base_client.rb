# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'json'
require 'hashie'
require 'mime-types'

module Hermes
  module Clients
    # Basic client for sending api requests
    class BaseClient
      class << self
        # Create a new Faraday
        #
        # @param url [String] url endpoint
        # @param content_type [String] content type of the data beign sent
        # @return [Faraday] basic connection
        def api_connection(url, content_type = 'application/json')
          Faraday.new(url: url) do |faraday|
            faraday.basic_auth(api_key, api_secret)
            faraday.adapter Faraday.default_adapter
            faraday.headers['Content-Type'] = content_type
            faraday.headers['Accept'] = 'application/json'
            faraday.headers['X-API-Version'] = Hermes.version
          end
        end

        private

        # Hermes API username
        #
        # @return [String] value of the api_key
        def api_key
          Rails.application.credentials.dig(:hermes, :api_key) || ENV['HERMES_API_KEY']
        rescue StandardError
          ENV['HERMES_API_KEY']
        end

        # Hermes API password
        #
        # @return [String] value of the api_secret
        def api_secret
          Rails.application.credentials.dig(:hermes, :api_secret) || ENV['HERMES_API_SECRET']
        rescue StandardError
          ENV['HERMES_API_SECRET']
        end

        # Hermes API base url
        #
        # @return [String] base url of the api endpoint
        def base_url
          ENV['HERMES_API_URL'] || 'https://hermes.mythcoders.net/api'
        end

        # def parse_response(response)
        #   return nil if response.body.empty?
        #
        #   JSON.parse(response.body)
        # rescue JSON::ParserError
        #   response.body
        # end
      end
    end
  end
end
