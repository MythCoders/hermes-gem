# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hermes::Gateway do
  describe '.new_mail' do
    include_context :mail

    it 'delegates to MailClient' do
      expect(Hermes::Clients::MailClient).to receive(:new_mail).with(messages_data)
      described_class.new_mail(messages_data)
    end
  end
end
