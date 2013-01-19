require 'spec_helper'
require 'noveku/core'

describe 'Core' do
  context 'environment' do
    it 'absence should raise an exception' do
      expect(-> { Noveku::Core.new }).to raise_error(Noveku::NotAValidEnvironment)
    end
  end

  context 'commands' do
    subject { Noveku::Core.new 'noveku-safe-env', 'rake', 'stats' }

    it 'environment should be the first command' do
      expect(subject.environment).to eq 'noveku-safe-env'
    end

    it 'main command should be the second command' do
      expect(subject.command).to eq 'rake'
    end

    it 'argument should be the remaining' do
      expect(subject.arguments).to eq ['stats']
    end

    it 'string to execute should contain given command' do
      str = "heroku run rake stats --remote 'noveku-safe-env'"
      expect(subject.send(:executable_command, 'run rake stats')).to eq str
    end

    it 'string to execute should chain given command' do
      str = "heroku run rake stats --remote 'noveku-safe-env' && heroku releases --remote 'noveku-safe-env'"
      expect(subject.send(:executable_command, 'run rake stats', 'releases')).to eq str
    end
  end
end
