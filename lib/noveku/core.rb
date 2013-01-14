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
      @command     = arguments.shift
      @arguments    = arguments
    end

    # Run the commands
    def call
      raise NotAValidEnvironment unless @environment

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
