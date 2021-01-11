# frozen_string_literal: true

require_relative 'email_converter'

module Hermes
  # Accepts [Mail] sent by Rails and delivers to Hermes
  class Mailbox
    def initialize(values)
      self.settings = {}.merge!(values)
    end

    attr_accessor :settings

    # Deliver an email to Hermes
    #
    # @param mail [Mail] email that is to be delivered
    # @return [Boolean] if the request was successful
    def deliver!(mail)
      @mail = mail
      Hermes::Gateway.new_mail mail_params
    # rescue Hermes::Error => e
    #   Hermes::DebugHandler.apply(debug_information)
    #   raise e
    end

    private

    def mail_params
      @mail_params ||= {
        message: Hermes::EmailConverter.convert(@mail).merge(environment)
      }
    end

    def environment
      @environment ||= { environment: @settings[:environment] }
    end

    def debug_information
      {
        mail: @mail,
        api_params: mail_params,
        api_client: Hermes.version
      }
    end
  end
end
