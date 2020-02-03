# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'json'
require 'hashie'
require_relative 'error'
require 'mime-types'

module Hermes
  class BaseClient
    DEFAULT_TIMEOUT = 60 # seconds, matches Net::Http's default which rest-client used

    class << self
      def api_connection(url, content_type: 'application/json')
        Faraday.new(url: url) do |faraday|
          faraday.basic_auth(try_api_key, try_api_secret)
          faraday.adapter Faraday.default_adapter
          faraday.headers['Content-Type'] = content_type
          faraday.headers['Accept'] = 'application/json'
        end
      end

      private

      def try_api_key
        # Normally this would be a good place to use Object#try, but the Rails 3
        # implementation doesn't rescue from NoMethodError like the Rails 4 one
        # does, and that's EXACTLY the use case we are supporting here.
        Rails.application.credentials.dig(:hermes, :api_key) || ENV['HERMES_API_KEY']
      rescue NoMethodError
        ENV['HERMES_API_KEY']
      end

      def try_api_secret
        Rails.application.credentials.dig(:hermes, :api_secret) || ENV['HERMES_API_SECRET']
      rescue NoMethodError
        ENV['HERMES_API_SECRET']
      end

      def try_base_url
        ENV['HERMES_API_URL'] ||= 'https://hermes.mythcoders.io/api/'
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
