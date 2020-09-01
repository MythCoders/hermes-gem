# frozen_string_literal: true

module Hermes
  class EmailConverter
    HTML = 'text/html'
    TXT = 'text/plain'

    class << self
      def convert(mail)
        @mail = mail
        mail_params
      end

      private

      def mail_params
        {
          to: @mail.to || [],
          cc: @mail.cc || [],
          bcc: @mail.bcc || [],
          subject: @mail.subject,
          sender: sender,
          body: body,
          content_type: content_type
        }
      end

      def sender
        @mail.from.first
      end

      def content_type
        @mail.content_type.include?('html') ? HTML : TXT
      end

      def body
        @mail.body.decoded
      end
    end
  end
end
