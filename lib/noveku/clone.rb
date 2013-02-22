module Noveku
  module Clone
    # Clone args
    def clone_cmd_args
      base = ["apps:create #{@app_name}"]

      cleaned_addons_list.each { |addon| base << addon_cmd_str(addon) }

      base
    end

    # Clone command
    def clone_cmd
      # Get the command from base env...
      commands = clone_cmd_args

      # Switch to new env and execute
      @environment = @new_environment

      execute_heroku *commands
    end
  end
end
