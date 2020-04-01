# frozen_string_literal: true

require_relative 'clients/base_client'
require_relative 'clients/mail_client'

module Hermes
  class Gateway
    class << self
      delegate :new_mail, to: :mail_client

      private

      def mail_client
        @mail_client ||= Hermes::Clients::MailClient
      end
    end
  end
end
