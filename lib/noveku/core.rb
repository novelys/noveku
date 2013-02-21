require 'noveku/cli/git'
require 'noveku/cli/heroku'
require 'noveku/config'
require 'noveku/console'
require 'noveku/deploy'
require 'noveku/exceptions'
require 'noveku/migrate'
require 'noveku/mongo'
require 'noveku/options'
require 'noveku/proxy'
require 'noveku/push'
require 'noveku/rake'
require 'noveku/tail'

module Noveku
  # Common functionnality
  class Core
    include Config
    include Exceptions
    include Options
    # Aliases
    include Console
    include Migrate
    include Proxy
    include Rake
    include Tail
    # Advanced Features
    include Deploy
    include Mongo
    include Push

    attr_reader :environment, :command, :arguments

    # Keep track of the given commands
    def initialize(*arguments)
      @environment = arguments.shift

      ensure_env
      ensure_heroku_app

      @command     = arguments.shift
      @arguments   = arguments
    rescue Exception => e
      handle_exception(e)
    end

    # Run the commands
    def call
      send "#{@command}_cmd"
    end

    # Prefix of heroku git remotes
    def prefix
      "heroku"
    end

    # Environment
    alias :branch :environment

    # Name of heroku remote
    def remote
      "#{prefix}-#{environment}"
    end

    private

    # Execute the commands
    def execute_heroku(*commands)
      options = (commands.last.is_a?(Hash) && commands.pop) || {}
      options = {dry_run: dry_run?, verbose: verbose?}.merge(options)

      h = Noveku::CLI::Heroku.new environment, *commands, options
      h.()
    end

    # Execute the commands
    def execute_git(*commands)
      options = (commands.last.is_a?(Hash) && commands.pop) || {}
      options = {dry_run: dry_run?, verbose: verbose?}.merge(options)

      g = Noveku::CLI::Git.new *commands, options
      g.()
    end
  end
end
