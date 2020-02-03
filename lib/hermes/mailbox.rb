# frozen_string_literal: true

module Hermes
  class Mailbox
    def initialize(*args)
      @environment = args[:environment]
    end

    def deliver!(mail)
      @mail = mail

      Hermes::Gateway.new.new_mail mail_params
    end

    private

    def mail_params
      {
        message:
            {
              to: @mail[:to],
              cc: @mail[:cc],
              bcc: @mail[:bcc],
              subject: @mail[:subject],
              body: @mail[:body],
              environment: @environment,
              content_type: @mail[:content_type],
              sender_name: sender_name,
              sender_email: sender_email
            }
      }
    end

    def sender_name
      @mail[:from]
    end

    def sender_email
      @mail[:from]
    end
  end
end
