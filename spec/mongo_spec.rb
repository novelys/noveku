require 'spec_helper'
require 'noveku/core'

describe 'Mongodump' do
  context 'MongoHQ' do
    subject { Noveku::Core.new 'staging', 'mongohq_dump' }

    it 'should raise an exception when no uri in the config' do
      expect(-> { subject.mongohq_dump_cmd }).to raise_error Noveku::Mongo::NoUriSupplied
    end
  end

  context 'MongoLab' do
    subject { Noveku::Core.new 'staging', 'mongolab_dump' }

    it 'should raise an exception when no uri in the config' do
      expect(-> { subject.mongohq_dump_cmd }).to raise_error Noveku::Mongo::NoUriSupplied
    end
  end


  subject { Noveku::Core.new 'staging', 'mongodump' }

  it 'should raise an exception when no uri in the config' do
    expect(-> { subject.mongodump_cmd }).to raise_error Noveku::Mongo::NoUriSupplied
  end
end
