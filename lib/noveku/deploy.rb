module Noveku
  module Deploy
    def deploy_cmd_str
      "push #{remote} #{branch}:master"
    end

    # Open the console
    def deploy_cmd
      execute_git(deploy_cmd_str)
    end
  end
end
