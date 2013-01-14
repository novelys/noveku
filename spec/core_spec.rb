require 'spec_helper'
require 'noveku/core'

describe 'Core' do
  context 'environment' do
    it 'absence should raise an exception' do
      noveku = Noveku::Core.new

      # `call` will be called implicitely
      expect(noveku).to raise_error(Noveku::NotAValidEnvironment)
    end
  end

  context 'commands' do
    subject { Noveku::Core.new 'staging', 'rake', 'stats' }

    it 'environment should be the first command' do
      expect(subject.environment).to eq 'staging'
    end

    it 'main command should be the second command' do
      expect(subject.command).to eq 'rake'
    end

    it 'argument should be the remaining' do
      expect(subject.arguments).to eq ['stats']
    end

    it 'string to execute should contain given command' do
      str = "heroku run rake stats --remote 'staging'"
      expect(subject.send(:executable_command, 'run rake stats')).to eq str
    end

    it 'string to execute should chain given command' do
      str = "heroku run rake stats --remote 'staging' && heroku releases --remote 'staging'"
      expect(subject.send(:executable_command, 'run rake stats', 'releases')).to eq str
    end
  end
end
