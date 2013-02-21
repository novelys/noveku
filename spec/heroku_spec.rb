require 'spec_helper'
require 'noveku/cli/heroku'

describe 'CLI' do
  context 'Heroku' do
    it 'string to execute should contain given command' do
      heroku = Noveku::CLI::Heroku.new 'noveku-safe-env', 'run rake stats'
      str = "heroku run rake stats --remote 'noveku-safe-env'"
      expect(heroku.command).to eq str
    end

    it 'string to execute should chain given command' do
      heroku = Noveku::CLI::Heroku.new 'noveku-safe-env', 'run rake stats', 'releases'
      str = "heroku run rake stats --remote 'noveku-safe-env' && heroku releases --remote 'noveku-safe-env'"
      expect(heroku.command).to eq str
    end
  end
end
