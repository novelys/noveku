require 'spec_helper'
require 'noveku/core'

describe 'Push' do
  subject { Noveku::Core.new 'noveku-safe-env', 'push' }

  it 'must have an executable command string' do
    expect(subject.push_cmd_str).to eq 'push origin noveku-safe-env'
  end
end