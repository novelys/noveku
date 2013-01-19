require 'noveku/config'
require 'noveku/exceptions'
require 'noveku/rake'
require 'noveku/console'
require 'noveku/migrate'
require 'noveku/proxy'
require 'noveku/tail'
require 'noveku/mongo'

module Noveku
  # Common functionnality
  class Core
    include Config
    include Exceptions
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
    rescue Exception => e
      handle_exception(e)
    end

    # Run the commands
    def call
      send "#{@command}_cmd"
    end

    private

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
