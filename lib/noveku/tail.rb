module Noveku
  module Tail
    # Tail command string
    def tail_cmd_str
      'logs --tail'
    end

    # Tail logs
    def tail_cmd
      execute_heroku tail_cmd_str
    end
  end
end
