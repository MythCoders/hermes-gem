# frozen_string_literal: true

require_relative 'email_converter'

module Hermes
  # Handles sending [Mail] to Hermes
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
    rescue Hermes::Error => e
      sentry_context if defined?(:Raven)
      raise e
    end

    private

    def mail_params
      Hermes::EmailConverter.convert(@mail).merge(environment)
    end

    def environment
      { message: { environment: @settings[:environment] } }
    end

    def sentry_context
      Raven.extra_context mail: @mail
      Raven.extra_context api_client: Hermes.version
    end
  end
end
