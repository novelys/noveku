module Noveku
  # Raised if environment is not present
  class NotAValidEnvironment < StandardError; end

  # Raised if `pwd` is not a git repo or no app was found
  class NoHerokuApp < StandardError; end

  module Mongo
    # Raised if no mongo uri was found
    class NoUriSupplied < StandardError; end
  end

  module Exceptions
    private

    # Some commands do not require an environment supplied
    def environmentless_command?
      @envless ||= (environment && environment == 'create')
    end

    # Check if environment is present
    def ensure_env
      raise NotAValidEnvironment unless @environment
    end

    # Check if there is a matching heroku app
    def ensure_heroku_app
      # This env is used for testing
      return if @environment == 'noveku-safe-env'

      system "heroku releases --remote '#{environment}' >& /dev/null"

      raise NoHerokuApp unless $?.exitstatus == 0
    end

    # Print message, then exits
    def handle_exception(e)
      explain_exception(e)
      exit(1)
    end

    # Print a message explaining error
    def explain_exception(e)
      case e
      when Noveku::NotAValidEnvironment
        explain_invalid_env
      when Noveku::NoHerokuApp
        explain_no_heroku
      when Noveku::Mongo::NoUriSupplied
        explain_no_uri
      else raise
      end
    end

    # Print a message explaining the env is not valid
    def explain_invalid_env
      explanation = <<-ENV
        You did not supply a environment to use.
      ENV

      puts explanation.strip
    end

    # Print a message explaining there is no herok
    def explain_no_heroku
      explanation = <<-HER
        The current directory doesn't seem to be a heroku app, or the environment given doesn't match a heroku app.
      HER

      puts explanation.strip
    end

    # Print a message explaining
    def explain_no_uri
      explanation = <<-URI
        There is no mongodb uri in the config.
      URI

      puts explanation.strip
    end
  end
end