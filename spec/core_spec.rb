require 'spec_helper'
require 'noveku/core'

describe 'Core' do
  context 'environment' do
    it 'absence should raise an exception' do
      expect(-> { Noveku::Core.new }).to raise_error(SystemExit)
    end
  end

  context 'commands' do
    subject { Noveku::Core.new 'noveku-safe-env', 'rake', 'stats' }

    it 'prefix should be "heroku"' do
      expect(subject.prefix).to eq 'heroku'
    end

    it 'environment should be the first command' do
      expect(subject.environment).to eq "noveku-safe-env"
    end

    it 'remote should be the prefixed environment' do
      expect(subject.remote).to eq "#{subject.prefix}-#{subject.environment}"
    end

    it 'main command should be the second command' do
      expect(subject.command).to eq 'rake'
    end

    it 'argument should be the remaining' do
      expect(subject.arguments).to eq ['stats']
    end
  end
end
