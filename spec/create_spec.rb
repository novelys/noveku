require 'spec_helper'
require 'noveku/core'

describe 'Create' do
  subject { Noveku::Core.new 'create', 'newenv' }

  it 'should be environmentless' do
    expect(subject.send(:environmentless_command?)).to be_true
  end

  it 'should have a prefixed remote' do
    expect(subject.remote).to eq "#{subject.prefix}-newenv"
  end

  context 'Without addons' do
    it 'must have an executable command string' do
      expect(subject.create_cmd_args).to eq ['apps:create newenv']
    end
  end

  context 'With addons' do
    subject { Noveku::Core.new 'create', 'newenv', 'addon:1', 'otherone' }

    it 'must have an executable command string' do
      expect(subject.create_cmd_args).to eq ['apps:create newenv', 'addons:add addon:1', 'addons:add otherone']
    end
  end
end
