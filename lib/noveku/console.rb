module Noveku
  module Console
    def console_cmd_str
      'run console'
    end

    # Open the console
    def console_cmd
      execute_heroku console_cmd_str
    end
  end
end
