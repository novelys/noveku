require 'spec_helper'
require 'noveku/core'

describe 'Tail' do
  subject { Noveku::Core.new 'staging', 'tail' }

  it 'must have an executable command string' do
    expect(subject.tail_cmd_str).to eq 'logs --tail'
  end
end
