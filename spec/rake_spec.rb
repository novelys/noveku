require 'spec_helper'
require 'noveku/core'

describe 'Rake' do
  subject { Noveku::Core.new 'staging', 'rake', 'arg1', 'arg2' }

  it 'must have an executable command string' do
    expect(subject.rake_cmd_str).to eq 'run rake arg1 arg2'
  end
end
