# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hermes::EmailConverter do
  describe '#convert' do
    include_context :mail
    subject { described_class.convert(mail) }

    it 'returns hash' do
      expect(subject).to be_a(Hash)
    end

    xit 'returns proper format for Hermes API' do
      expect(subject).to eq(messages_data)
    end

    it 'converts subject' do
      expect(subject[:subject]).to eq(mail.subject)
    end

    it 'converts body' do
      expect(subject[:body]).to eq(mail.body.decoded)
    end

    it 'converts sender' do
      expect(subject[:sender]).to eq(mail.from.first)
    end

    it 'converts content_type' do
      expect(subject[:content_type]).to eq(mail.content_type)
    end

    context 'when no cc or bcc are supplied' do
      let(:cc) { [] }
      let(:bcc) { [] }

      it 'cc and bcc are empty' do
        expect(subject[:cc]).to eq(mail.cc)
        expect(subject[:bcc]).to eq(mail.bcc)
      end
    end

    context 'when multiple cc or bcc are supplied' do
      let(:cc) { [Faker::Internet.email, Faker::Internet.email] }
      let(:bcc) { [Faker::Internet.email, Faker::Internet.email] }

      it 'all emails are copied' do
        expect(subject[:cc]).to eq(mail.cc)
        expect(subject[:bcc]).to eq(mail.bcc)
      end
    end

    context 'when a funky context_type is provided' do
      junklet :content_type

      it 'default to plain text' do
        expect(subject[:content_type]).to eq(described_class::TXT)
      end
    end

    context 'when content_type contains html' do
      let(:content_type) { described_class::HTML }

      it 'uses full content type' do
        expect(subject[:content_type]).to eq(described_class::HTML)
      end
    end
  end
end
