# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'json'
require 'hashie'
require 'active_support/core_ext/object/to_param'
require 'active_support/core_ext/object/to_query'
require 'hermes/error'
require 'mime-types'

module Hermes
  module ApiRequest
    DEFAULT_TIMEOUT = 60 # seconds, matches Net::Http's default which rest-client used

    def base_request(http_method, host, path, params = {}, auth_type = :basic)
      params  = params.symbolize_keys
      headers = params.delete(:headers) || {}
      timeout = params.delete(:timeout) || DEFAULT_TIMEOUT

      conn = Faraday.new host do |faraday|
        faraday.request  :multipart
        faraday.request  :url_encoded
        faraday.response :follow_redirects
        faraday.adapter  :typhoeus
      end
      case auth_type
      when :basic
        conn.basic_auth @username, @password
      when :bearer
        conn.authorization :Bearer, "#{@username}+#{params.delete(:token_id)}"
      end

      response = conn.send http_method do |request|
        request.url path
        request.options.timeout = timeout
        request.params = params
        request.headers.merge! headers
        request.body = block_given? ? yield : {}
      end
      unless response.success?
        raise Error::HTTPError.new(response.status, response.body, http_method, url(host, path, params))
      end

      parse_response response
    end

    def parse_response(response)
      return nil if response.body.empty?

      JSON.parse(response.body)
    rescue JSON::ParserError
      response.body
    end

    def url(host, path, params)
      "#{host}#{path}".tap do |url|
        url << "?#{params.to_query}" if params.present?
      end
    end
  end
end
