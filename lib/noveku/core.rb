require 'noveku/config'
require 'noveku/rake'
require 'noveku/console'
require 'noveku/migrate'
require 'noveku/proxy'
require 'noveku/tail'
require 'noveku/mongo'

module Noveku
  # This exception will be raised if @environment is not present
  class NotAValidEnvironment < StandardError; end

  # This exception will be raised if `pwd` is not a git repo or no app was found
  class NoHerokuApp < StandardError; end

  # Common functionnality
  class Core
    include Config
    # Aliases
    include Rake
    include Console
    include Migrate
    include Proxy
    include Tail
    # Advanced Features
    include Mongo

    attr_reader :environment, :command, :arguments

    # Keep track of the given commands
    def initialize(*arguments)
      @environment = arguments.shift

      ensure_env
      ensure_heroku_app

      @command     = arguments.shift
      @arguments   = arguments
    end

    # Run the commands
    def call
      send "#{@command}_cmd"
    end

    private

    # Check if environment is present
    def ensure_env
      raise NotAValidEnvironment unless @environment
    end

    # Check if there is a matching heroku app
    def ensure_heroku_app
      # This env is used for testing
      return if environment == 'noveku-safe-env'

      system "heroku releases --remote '#{environment}' >& /dev/null"

      raise NoHerokuApp unless $?.exitstatus == 0
    end

    # Execute the commands
    def execute(*commands)
      system executable_command(*commands)
    end

    # Build command to execute
    def executable_command(*commands)
      return nil unless commands

      # Template proc
      template = ->(command) { "heroku #{command} --remote '#{environment}'" }

      # Map commands to template & chain
      commands.map(&template).join(' && ')
    end
  end
end
