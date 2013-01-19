require 'spec_helper'
require 'noveku/core'

describe 'Config' do
  subject { Noveku::Core.new 'staging' }

  it 'must have an executable command string' do
    key = (0...4).map{65.+(rand(26)).chr}.join('')

    expect(subject.config_value_str(key)).to eq "config:get #{key}"
  end
end
