require 'spec_helper'
require 'noveku/core'

describe 'Tail' do
  subject { Noveku::Core.new 'noveku-safe-env', 'tail' }

  it 'must have an executable command string' do
    expect(subject.tail_cmd_str).to eq 'logs --tail'
  end
end
