# frozen_string_literal: true

module Hermes
  class MailClient < BaseClient
    class << self
      def new_mail(message)
        conn = api_connection api_url
        response = conn.post { |req| req.body = JSON.dump(message) }

        return true if response.success?

        raise Hermes::Error.new(response.status, response.body)
      end

      private

      def api_url
        base_url + 'messages'
      end
    end
  end
end
