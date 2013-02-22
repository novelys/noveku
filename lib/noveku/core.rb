require 'noveku/cli/git'
require 'noveku/cli/heroku'
require 'noveku/config'
require 'noveku/console'
require 'noveku/create'
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
    include Create
    include Deploy
    include Mongo
    include Push

    attr_reader :environment, :command, :arguments

    # Keep track of the given commands
    def initialize(*arguments)
      @environment = arguments.shift

      if environmentless_command?
        arguments.unshift @environment
        @environment = nil
      else
        ensure_env
        ensure_heroku_app
      end

      @command     = arguments.shift
      @arguments   = arguments

      post_arguments_handling
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

    # Post treatment of arguments
    def post_arguments_handling
      return unless environmentless_command?

      @environment = arguments[0].dup
    end

    # Execute the commands
    def execute_heroku(*commands)
      options = (commands.last.is_a?(Hash) && commands.pop) || {}
      options = {dry_run: dry_run?, verbose: verbose?}.merge(options)

      h = Noveku::CLI::Heroku.new environment, *commands, options
      h.noveku = self
      h.()
    end

    # Execute the commands
    def execute_git(*commands)
      options = (commands.last.is_a?(Hash) && commands.pop) || {}
      options = {dry_run: dry_run?, verbose: verbose?}.merge(options)

      g = Noveku::CLI::Git.new *commands, options
      g.noveku = self
      g.()
    end
  end
end
