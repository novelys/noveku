require 'spec_helper'
require 'noveku/core'
require 'noveku/cli/heroku'

describe 'CLI' do
  context 'Heroku' do
    let(:core) { Noveku::Core.new 'noveku-safe-env', 'notrelevant'}

    it 'string to execute should contain given command' do
      heroku = Noveku::CLI::Heroku.new 'noveku-safe-env', 'run rake stats'
      heroku.noveku = core
      str = "heroku run rake stats --remote '#{heroku.noveku.prefix}-noveku-safe-env'"
      expect(heroku.command).to eq str
    end

    it 'string to execute should chain given command' do
      heroku = Noveku::CLI::Heroku.new 'noveku-safe-env', 'run rake stats', 'releases'
      heroku.noveku = core
      str = "heroku run rake stats --remote '#{heroku.noveku.prefix}-noveku-safe-env' && heroku releases --remote '#{heroku.noveku.prefix}-noveku-safe-env'"
      expect(heroku.command).to eq str
    end
  end
end
