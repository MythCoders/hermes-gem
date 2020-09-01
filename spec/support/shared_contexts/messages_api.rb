# frozen_string_literal: true

RSpec.shared_context :messages_api do
  include_context :mail

  let(:base_url) { ENV['HERMES_API_URL'] || 'https://hermes.mythcoders.net/api/' }
  let(:messages_url) { "#{base_url}messages" }
  let(:messages_api_status) { 200 }

  before do
    stub_request(:post, messages_url)
      .and_return(status: messages_api_status)
  end
end
