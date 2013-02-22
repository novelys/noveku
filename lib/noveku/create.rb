module Noveku
  module Create
    # Create args
    def create_cmd_args
      base = ["apps:create #{@app_name}"]

      proxied_arguments.each { |addon| base << addon_cmd_str(addon) }

      base
    end

    # Open the console
    def create_cmd
      execute_heroku *create_cmd_args
    end
  end
end
