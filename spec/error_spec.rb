# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hermes::Error do
  junklet :message, :status
  subject { described_class.new(status, message) }

  describe '#to_s' do
    it 'includes message' do
      expect(subject.to_s).to include(message)
    end

    it 'includes status' do
      expect(subject.to_s).to include(status)
    end
  end
end
