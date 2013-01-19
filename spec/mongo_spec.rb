require 'spec_helper'
require 'noveku/core'

describe 'Mongodump' do
  context 'MongoHQ' do
    subject { Noveku::Core.new 'noveku-safe-env', 'mongohq_dump' }

    it 'should raise an exception when no uri in the config' do
      expect(-> { subject.mongohq_dump_cmd }).to raise_error Noveku::Mongo::NoUriSupplied
    end
  end

  context 'MongoLab' do
    subject { Noveku::Core.new 'noveku-safe-env', 'mongolab_dump' }

    it 'should raise an exception when no uri in the config' do
      expect(-> { subject.mongohq_dump_cmd }).to raise_error Noveku::Mongo::NoUriSupplied
    end
  end


  subject { Noveku::Core.new 'noveku-safe-env', 'mongodump' }

  it 'should raise an exception when no uri in the config' do
    expect(-> { subject.mongodump_cmd }).to raise_error Noveku::Mongo::NoUriSupplied
  end
end
