# frozen_string_literal: true

module Hermes
  class Mailbox
    attr_accessor :settings

    def initialize(values)
      self.settings = {}.merge!(values)
    end

    def deliver!(mail)
      @mail = mail
      puts mail.inspect

      Hermes::Gateway.new_mail mail_params
    rescue Hermes::Error => e
      Raven.extra_context mail: mail
      Raven.extra_context api_params: mail_params
      Raven.extra_context api_client: Hermes.version
      raise e
    end

    private

    def mail_params
      {
        message:
            {
              to: @mail.to || [],
              cc: @mail.cc || [],
              bcc: @mail.bcc || [],
              subject: @mail.subject,
              sender: sender,
              body: body,
              environment: environment,
              content_type: content_type
            }
      }
    end

    def sender
      @mail.from.first
    end

    def content_type
      @mail.content_type.include?('html') ? 'html' : 'txt'
    end

    def body
      @mail.body.encoded
    end

    def environment
      @settings[:environment]
    end
  end
end
