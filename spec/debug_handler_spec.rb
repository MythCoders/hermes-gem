# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Lint/ConstantDefinitionInBlock, Style/ClassAndModuleChildren
RSpec.xdescribe Hermes::DebugHandler do
  describe '#apply' do
    # context 'when nothing' do
    #   described_class.apply dave: 'dave'
    #   expect(Raven).not_to receive(:extra_context)
    #   expect(Sentry).not_to receive(:set_extras)
    # end

    context 'when the Raven module is defined' do
      module self::Raven
        def self.extra_context(*args); end
      end

      it 'logs extra_context' do
        allow(Raven).to receive(:extra_context)
        described_class.apply dave: 'dave'
        expect(Raven).to have_received(:extra_context).at_least(:once)
      end
    end

    context 'when the Sentry module is defined' do
      module self::Sentry
        # rubocop:disable Naming/AccessorMethodName
        def self.set_extras(*args); end
        # rubocop:enable Naming/AccessorMethodName
      end

      it 'logs set_extras' do
        allow(Sentry).to receive(:set_extras)
        described_class.apply dave: 'dave'
        expect(Sentry).to have_received(:set_extras).at_least(:once)
      end
    end
  end
end
# rubocop:enabled Lint/ConstantDefinitionInBlock, Style/ClassAndModuleChildren
