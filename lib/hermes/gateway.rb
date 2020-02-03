# frozen_string_literal: true

module Hermes
  class Gateway
    delegate :new_mail, to: :mail_client

    private

    def mail_client
      Hermes::MailClient
    end
  end
end
