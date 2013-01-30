require 'spec_helper'
require 'noveku/core'

describe 'Options handler' do
  context 'Dry run' do
    subject { Noveku::Core.new 'noveku-safe-env', 'anycommandyoulike', '--dry-run' }

    it 'recognizes the long form option' do
      expect(subject.dry_run?).to be_true
    end

    it 'does not proxy the option' do
      expect(subject.proxied_arguments).not_to include '--dry-run'
    end
  end

  context 'Verbose' do
    subject { Noveku::Core.new 'noveku-safe-env', 'anycommandyoulike', '--verbose' }

    it 'recognizes the long form option' do
      expect(subject.verbose?).to be_true
    end

    it 'does not proxy the option' do
      expect(subject.proxied_arguments).not_to include '--verbose'
    end
  end
end