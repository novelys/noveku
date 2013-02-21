module Noveku
  module CLI
    class Base
      attr_reader :commands

      # Extract commands & options
      def initialize(*commands)
        @options = (commands.last.is_a?(Hash) && commands.pop) || {}
        @commands = commands
      end

      # Only print
      def dry_run?
        @options[:dry_run]
      end

      # Print & execute
      def verbose?
        @options[:verbose]
      end

      # Hide stderr ?
      def hide_stderr?
        !!(@options[:hide_stderr])
      end

      # Hide stderr ?
      def hide_stdout?
        !!(@options[:hide_stdout])
      end

      # Hide stderr & stdout ?
      def hide_both?
        hide_stderr? && hide_stdout?
      end

      # Execute the commands
      def call
        print if dry_run? || verbose?
        system(command) unless dry_run?
      end

      # Only print the command
      def print
        puts command
      end

      # The command template, with stream redirection handled
      def template_command_with_output_cleaned(*args)
        base = template_command(*args)

        stream = if hide_both?
          '&'
        elsif hide_stderr?
          '2'
        elsif hide_stdout?
          '1'
        end

        base = "#{base} #{stream}> /dev/null" if stream
        base
      end

      # Command string to execute
      def command
        return nil unless commands

        # Map commands to template & chain
        commands.map(&method(:template_command_with_output_cleaned)).join(' && ')
      end
    end
  end
end
