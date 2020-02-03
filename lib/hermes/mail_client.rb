# frozen_string_literal: true

module Hermes
  class MailClient < BaseClient
    def new_mail(message)
      conn = api_connection api_url
      response = conn.post { |req| req.body = message }

      raise StandardError unless response.success?

      true
    end

    private

    def api_url
      try_base_url + 'mail'
    end
  end
end
