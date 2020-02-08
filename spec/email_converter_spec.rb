# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hermes::EmailConverter do
  describe '#convert' do
    include_context :mail
    subject { described_class.convert(mail) }

    it 'returns hash' do
      expect(subject).to be_a(Hash)
    end

    it 'returns proper format for Hermes API' do
      expect(subject).to eq(messages_data)
    end

    context 'when content_type is html' do
      let(:body) { html_body }
      let(:content_type) { 'text/html' }

      it 'returns proper format for Hermes API' do
        expect(subject).to eq(messages_data)
      end
    end
  end
end
