# frozen_string_literal: true

require_relative 'api_request'
require_relative 'client/mail'

module Hermes
  class Client
    include Hermes::Mail

    # use the block to set module privided instance variables:
    # ```ruby
    # Client.new('mark') do |client|
    #   client.contacts_path = '/'
    #   client.contacts_host = 'http://contacts-api.dev'
    # end
    # ```
    #
    # Defaults are to proudction to make it easy for external gem consumers.
    def initialize(username, password = nil)
      @username = username
      @password = password
      yield(self) if block_given?
    end

    attr_writer :default_host
    def default_host
      @default_host ||= 'https://hermes.mythcoders.io/api/'
    end
  end
end
