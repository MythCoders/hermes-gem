# frozen_string_literal: true

require_relative 'base_client'
require_relative 'mail_client'

module Hermes
  class Gateway
    class << self
      delegate :new_mail, to: :mail_client

      private

      def mail_client
        @mail_client ||= Hermes::MailClient
      end
    end
  end
end
