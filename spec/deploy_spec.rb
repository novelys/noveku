require 'spec_helper'
require 'noveku/core'

describe 'Deploy' do
  subject { Noveku::Core.new 'noveku-safe-env', 'deploy' }

  it 'must have an executable command string' do
    expect(subject.deploy_cmd_str).to eq 'push noveku-safe-env noveku-safe-env:master'
  end
end