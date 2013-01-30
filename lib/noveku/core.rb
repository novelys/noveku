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

    private

    # Only print the command
    def print_heroku(*commands)
      puts executable_heroku_command(*commands)
    end

    # Execute the commands
    def execute_heroku(*commands)
      print_heroku(*commands) if dry_run? || verbose?
      system(executable_heroku_command(*commands)) unless dry_run?
    end

    # Build command to execute
    def executable_heroku_command(*commands)
      return nil unless commands

      # Template proc
      template = ->(command) { "heroku #{command} --remote '#{environment}'" }

      # Map commands to template & chain
      commands.map(&template).join(' && ')
    end

    # Only print the command
    def print_git(*commands)
      puts executable_git_command(*commands)
    end

    # Execute the commands
    def execute_git(*commands)
      print_git(*commands) if dry_run? || verbose?
      system(executable_git_command(*commands)) unless dry_run?
    end

    # Build command to execute
    def executable_git_command(*commands)
      return nil unless commands

      # Template proc
      template = ->(command) { "git #{command}" }

      # Map commands to template & chain
      commands.map(&template).join(' && ')
    end
  end
end
