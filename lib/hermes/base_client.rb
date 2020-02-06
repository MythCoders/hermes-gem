# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'json'
require 'hashie'
require 'mime-types'

module Hermes
  class BaseClient
    class << self
      def api_connection(url, content_type: 'application/json')
        Faraday.new(url: url) do |faraday|
          faraday.basic_auth(api_key, api_secret)
          faraday.adapter Faraday.default_adapter
          faraday.headers['Content-Type'] = content_type
          faraday.headers['Accept'] = 'application/json'
        end
      end

      private

      def api_key
        @api_key ||= Rails.application.credentials.dig(:hermes, :api_key) || ENV['HERMES_API_KEY']
      end

      def api_secret
        @api_secret ||= Rails.application.credentials.dig(:hermes, :api_secret) || ENV['HERMES_API_SECRET']
      end

      def base_url
        @base_url ||= ENV['HERMES_API_URL'] || 'https://hermes.mythcoders.io/api/'
      end

      def parse_response(response)
        return nil if response.body.empty?

        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body
      end
    end
  end
end
