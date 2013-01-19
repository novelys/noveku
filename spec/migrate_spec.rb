require 'spec_helper'
require 'noveku/core'

describe 'Migrate' do
  subject { Noveku::Core.new 'staging', 'migrate' }

  it 'must have a command args' do
    expect(subject.migrate_cmd_args).to eq ['run rake db:migrate', 'restart']
  end
end
