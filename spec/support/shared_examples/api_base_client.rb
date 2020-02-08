# frozen_string_literal: true

RSpec.shared_examples 'Hermes::BaseClient' do
  let(:base_api_url) { ENV['HERMES_API_URL'] }
  let(:api_key) { ENV['HERMES_API_KEY'] }
  let(:api_secret) { ENV['HERMES_API_SECRET'] }

  describe '.api_connection' do
    before do
      allow(Faraday).to receive(:new).with(url: base_api_url).and_call_original
    end

    context 'when Content-Type is specified' do
      let(:content_type) { 'application/csv' }

      it 'is a Faraday client with correct Content-Type header' do
        expect(
          described_class
            .api_connection(base_api_url, content_type)
            .headers
        ).to include('Content-Type' => content_type)
      end
    end
  end
end
