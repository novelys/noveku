require 'spec_helper'
require 'noveku/core'

describe 'Console' do
  subject { Noveku::Core.new 'noveku-safe-env', 'console' }

  it 'must have an executable command string' do
    expect(subject.console_cmd_str).to eq 'run console'
  end
end
