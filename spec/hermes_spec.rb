# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Hermes do
  describe '#version' do
    it 'includes correct version number' do
      expect(described_class.version).to include(Hermes::VERSION)
    end
  end
end
