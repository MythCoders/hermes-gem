# frozen_string_literal: true

module Hermes
  class Railtie < Rails::Railtie
    config.hermes = ActiveSupport::OrderedOptions.new
    config.cover_my_meds.default_host = 'https://api.covermymeds.com/'

    # Create (and cache) a configured API client instance using the id/secret
    # stored in `Rails.application.secrets` and the configuration specified
    # here and in `Rails.application.config.cover_my_meds`
    def default_client
      @default_client ||= configured_client *credentials
    end

    # Create a configured API client class with the configuration stored on the
    # app.  Useful if you want to use the same host/path configuration as the
    # rest of the app, but a different id/secret pair
    def configured_client(api_id, secret = nil)
      CoverMyMeds::Client.new api_id, secret do |client|
        config.cover_my_meds.each do |k, v|
          client.send "#{k}=".to_sym, v
        end
      end
    end

    def deliver!(message)
      puts 'Custom deliver for message: ' + message.to_s
    end

    private

    def credentials
      [try_api_id, try_secret]
    end

    def try_api_id
      # Normally this would be a good place to use Object#try, but the Rails 3
      # implementation doesn't rescue from NoMethodError like the Rails 4 one
      # does, and that's EXACTLY the use case we are supporting here.
      Rails.application.credentials.dig(:hermes, :api_key) || ENV['HERMES_API_KEY']
    rescue NoMethodError
      ENV['HERMES_API_KEY']
    end

    def try_secret
      Rails.application.credentials.dig(:hermes, :api_secret) || ENV['HERMES_API_SECRET']
    rescue NoMethodError
      ENV['HERMES_API_SECRET']
    end
  end
end
