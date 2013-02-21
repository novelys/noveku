require 'noveku/cli/base'

module Noveku
  module CLI
    class Heroku < Base
      attr_reader :environment

      # Extract environment from commands
      def initialize(*commands)
        super
        @environment = @commands.shift
      end

      # Template for commands
      def template_command(command)
        "heroku #{command} --remote '#{environment}'"
      end
    end
  end
end
