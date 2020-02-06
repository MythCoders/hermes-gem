# frozen_string_literal: true

module Hermes
  class Mailbox
    HTML = 'html'
    TXT = 'txt'

    def initialize(values)
      self.settings = {}.merge!(values)
    end

    attr_accessor :settings

    def deliver!(mail)
      @mail = mail

      Hermes::Gateway.new_mail mail_params
    rescue Hermes::Error => e
      sentry_context if Required::Module.const_defined?(:Raven)
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
      @sender ||= @mail.from.first
    end

    def content_type
      @content_type ||= @mail.content_type.include?(HTML) ? HTML : TXT
    end

    def body
      @body ||= content_type == HTML ? @mail.html_part.body.decoded : @mail.text_part
    end

    def environment
      @settings[:environment]
    end

    def sentry_context
      Raven.extra_context mail: mail
      Raven.extra_context api_params: mail_params
      Raven.extra_context api_client: Hermes.version
    end
  end
end
