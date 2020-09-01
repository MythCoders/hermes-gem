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

    it 'converts html body' do
      expect(subject[:html_body]).to eq(mail.html_part.decoded)
    end

    it 'converts text body' do
      expect(subject[:text_body]).to eq(mail.text_part.decoded)
    end

    it 'converts sender' do
      expect(subject[:sender]).to eq(mail.from.first)
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
  end
end
