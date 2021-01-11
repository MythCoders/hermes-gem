# frozen_string_literal: true

module Hermes
  class DebugHandler
    def initialize(error_debug_information)
      @error_debug_information = error_debug_information
    end

    def self.apply(error_debug_information)
      new(error_debug_information).apply
    end

    def apply
      if Module.const_defined?(:Raven)
        Raven.extra_context @error_debug_information
      elsif Module.const_defined?(:Sentry)
        Sentry.set_extras @error_debug_information
      end
    end
  end
end
