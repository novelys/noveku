require 'spec_helper'
require 'noveku/core'

describe 'Clone' do
  let(:app_less) { Noveku::Core.new 'clone' }
  let(:new_env_less) { Noveku::Core.new 'clone', 'newapp' }
  let(:base_env_less) { Noveku::Core.new 'clone', 'newapp', 'new-env' }
  subject { Noveku::Core.new 'clone', 'newapp', 'new-env', 'base-env' }

  it 'should have the app name supplied' do
    expect(-> {app_less}).to raise_error(ArgumentError)
  end

  it 'should have the new env name supplied' do
    expect(-> {new_env_less}).to raise_error(ArgumentError)
  end

  it 'should have the base env name supplied' do
    expect(-> {base_env_less}).to raise_error(ArgumentError)
  end

  it 'should be environmentless' do
    expect(subject.send(:environmentless_command?)).to be_true
  end
end
