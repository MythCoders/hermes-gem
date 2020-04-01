# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hermes::Mailbox do
  let(:environment) { 'test' }
  subject { Hermes::Mailbox.new(environment: environment) }

  it 'settings contains correct env value' do
    expect(subject.settings[:environment]).to eq(environment)
  end

  describe '.deliver!' do
    include_context :mail

    before do
      messages_data.merge!(message: { environment: environment })
    end

    it 'calls EmailConverter' do
      allow(Hermes::Gateway).to receive(:new_mail).with(messages_data).and_return(true)
      expect(Hermes::EmailConverter).to receive(:convert).with(mail).and_call_original
      subject.deliver!(mail)
    end

    it 'calls Gateway' do
      expect(Hermes::Gateway).to receive(:new_mail).with(messages_data)
      subject.deliver!(mail)
    end

    context 'when the API can not be found' do
      include_context :messages_api
      let(:messages_api_status) { 404 }
      let(:messages_data) { {} }

      it 'throws an error to be logged' do
        expect { subject.deliver!(mail) }.to raise_exception(Hermes::Error)
        expect(Raven).not_to receive(:extra_context)
      end

      context 'when Raven module is defined' do
        module Raven
          def self.extra_context(*args); end
        end

        it 'logs extra_context' do
          allow(Raven).to receive(:extra_context)
          expect { subject.deliver!(mail) }.to raise_exception(Hermes::Error)
          expect(Raven).to have_received(:extra_context).at_least(:once)
        end
      end
    end
  end
end
