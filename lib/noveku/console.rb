module Noveku
  module Console
    def console_cmd_str
      'run console'
    end

    # Open the console
    def console_cmd
      execute console_cmd_str
    end
  end
end
