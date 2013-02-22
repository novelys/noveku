require 'spec_helper'
require 'noveku/core'

describe 'Create' do
  subject { Noveku::Core.new 'create', 'newenv' }

  it 'should be environmentless' do
    expect(subject.send(:environmentless_command?)).to be_true
  end

  it 'must have an executable command string' do
    expect(subject.create_cmd_str).to eq 'apps:create newenv'
  end

  it 'should have a prefixed remote' do
    expect(subject.remote).to eq "#{subject.prefix}-newenv"
  end
end
