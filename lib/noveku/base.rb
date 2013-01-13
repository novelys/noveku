module Noveku
  # Heroku config keys name
  MONGOLAB_KEY = 'MONGOLAB_URI'
  MONGOHQ_KEY = 'MONGOHQ_URL'

  # This exception will be raised if @environment is not present
  class NotAValidEnvironment < StandardError; end

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

    # Dump mongolab or mongohq db
    def mongodump_cmd
      uri = config_value_for(MONGOLAB_KEY) || config_value_for(MONGOHQ_KEY)

      mongo_dump uri
    end

    # Dump mongolab db
    def mongolab_dump_cmd
      mongo_dump config_value_for(MONGOLAB_KEY)
    end

    # Dump mongohq db
    def mongohq_dump_cmd
      mongo_dump config_value_for(MONGOHQ_KEY)
    end

    def method_missing(name, *args, &block)
      # If this is a command with no specific support, pass the raw arguments to `heroku` directly
      if name.to_s.end_with?('_cmd')
        system "heroku #{@commands.join(' ')} --remote #{@environment}"
      else
        super
      end
    end

    private

    # Returns config value for key
    def config_value_for(key)
      uri = `heroku config:get #{key} --remote #{@environment}`.strip
      uri = nil if uri == ''
      uri
    end

    # Returns a hash of data parsed from the mongo uri
    def mongo_uri_parse(uri)
      matches = uri.match /mongodb:\/\/([^:]*):([^@]*)@([^:]*):(\d*)\/(.*)/i

      {
        user:     matches[1],
        password: matches[2],
        host:     matches[3],
        port:     matches[4],
        database: matches[5]
      }
    end

    # Get a dump of the database
    def mongo_dump(uri)
      if uri 
        opts = mongo_uri_parse uri

        puts "Dumping `#{opts[:database]}` from #{opts[:host]}..."
        system "mongodump -h #{opts[:host]}:#{opts[:port]} -d #{opts[:database]} -u #{opts[:user]} -p #{opts[:password]}"
        puts 'Done.'
      else
        puts 'No uri.'
      end
    end
  end
end
