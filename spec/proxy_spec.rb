require 'spec_helper'
require 'noveku/core'

describe 'Proxy' do
  subject { Noveku::Core.new 'noveku-safe-env', 'ps', 'web' }

  it 'must have an executable command string' do
    expect(subject.proxy_cmd_str).to eq 'ps web'
  end

  it 'should be called when missing method ends with _cmd' do
    valid_method_name = "#{(0...8).map{65.+(rand(26)).chr}.join}_cmd"
    expect(subject).to respond_to valid_method_name
  end
end
