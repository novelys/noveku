require 'noveku/cli/base'

module Noveku
  module CLI
    class Git < Base
      # Template for commands
      def template_command(command)
        "git #{command}"
      end
    end
  end
end
