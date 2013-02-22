module Noveku
  module Create
    # Migrate args
    def create_cmd_str
      "apps:create #{environment}"
    end

    # Open the console
    def create_cmd
      execute_heroku create_cmd_str
    end
  end
end
