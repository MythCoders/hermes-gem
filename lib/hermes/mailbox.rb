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
      Raven.extra_context message: mail_params
      raise e
    end

    private

    def mail_params
      {
        message:
            {
              to: @mail.to || nil,
              cc: @mail.cc || nil,
              bcc: @mail.bcc || nil,
              subject: @mail.subject,
              sender: sender,
              body: body,
              environment: environment,
              content_type: content_type
            }
      }
    end

    def sender
      @mail.from
    end

    def content_type
      @mail.content_type.include?('html') ? 'html' : 'txt'
    end

    def body
      content_type == 'html' ? @mail.html_part : @mail.text_part
    end

    def environment
      @settings[:environment]
    end
  end
end
