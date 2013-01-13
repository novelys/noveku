module Noveku
  # This exception will be raised if @environment is not present
  class NotAValidEnvironment < StandardError
  end

  # Common functionnality
  class Base
    # Keep track of the given commands
    def initialize(commands)
      @commands = commands
      @command = @commands.first
    end

    # Run the commands
    def run
      raise NotAValidEnvironment unless @environment

      send "#{@command}_cmd"
    end

    # Execute a rake task
    def rake_cmd
      task = @commands[1..-1].join(' ')
      system "heroku run rake #{task} --remote #{@environment}"
    end

    # Open the console
    def console_cmd
      system "heroku run console --remote #{@environment}"
    end

    # Execute migrations & restart app
    def migrate_cmd
      system %{
        heroku run rake db:migrate --remote #{@environment} &&
        heroku restart --remote #{@environment}
      }
    end

    # Tail logs
    def tail_cmd
      system "heroku logs --tail --remote #{@environment}"
    end

    def method_missing(name, *args, &block)
      # If this is a command with no specific support, pass the raw arguments to `heroku` directly
      if name.to_s.end_with?('_cmd')
        system "heroku #{@commands.join(' ')} --remote #{@environment}"
      else
        super
      end
    end
  end
end
