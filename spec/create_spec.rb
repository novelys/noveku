require 'spec_helper'
require 'noveku/core'

describe 'Create' do
  let(:app_less) { Noveku::Core.new 'create' }
  let(:env_less) { Noveku::Core.new 'create', 'newapp' }
  subject { Noveku::Core.new 'create', 'newapp', 'env-name' }

  it 'should have the app name supplied' do
    expect(-> {app_less}).to raise_error(ArgumentError)
  end

  it 'should have the env name supplied' do
    expect(-> {env_less}).to raise_error(ArgumentError)
  end

  it 'should be environmentless' do
    expect(subject.send(:environmentless_command?)).to be_true
  end

  it 'should have a prefixed remote' do
    expect(subject.remote).to eq "#{subject.prefix}-env-name"
  end

  context 'Without addons' do
    it 'must have an executable command string' do
      expect(subject.create_cmd_args).to eq ['apps:create newapp']
    end
  end

  context 'With addons' do
    subject { Noveku::Core.new 'create', 'newapp', 'env-name', 'addon:1', 'otherone' }

    it 'must have an executable command string' do
      expect(subject.create_cmd_args).to eq ['apps:create newapp', 'addons:add addon:1', 'addons:add otherone']
    end
  end
end
