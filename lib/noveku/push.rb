module Noveku
  module Push
    def push_cmd_str
      "push origin #{environment}"
    end

    # Open the console
    def push_cmd
      execute_git(push_cmd_str)
    end
  end
end
