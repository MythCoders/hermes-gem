# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hermes::Clients::MailClient do
  include_context :messages_api

  it_behaves_like 'Hermes::Clients::BaseClient'

  describe '.new_mail' do
    context 'when the API can not be found' do
      let(:messages_api_status) { 404 }
      let(:messages_data) { {} }

      it 'throws an error to be logged' do
        expect { described_class.new_mail(messages_data) }.to raise_exception(Hermes::Error)
      end
    end

    context 'when there is an error communicating with the API' do
      let(:messages_api_status) { 500 }
      let(:messages_data) { {} }

      it 'throws an error to be logged' do
        expect { described_class.new_mail(messages_data) }.to raise_exception(Hermes::Error)
      end
    end

    context 'when the API call is successful' do
      let(:messages_api_status) { 202 }
      let(:messages_data) { {} }

      it 'throws returns true' do
        expect(described_class.new_mail(messages_data)).to be(true)
      end
    end
  end
end
