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
          html_body: html_body,
          text_body: text_body
        }
      end

      def sender
        @mail.from.first
      end

      def html_body
        @mail.html_part&.decoded
      end

      def text_body
        @mail.text_part&.decoded
      end
    end
  end
end
