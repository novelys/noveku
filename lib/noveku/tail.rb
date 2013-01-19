module Noveku
  module Tail
    # Tail command string
    def tail_cmd_str
      'logs --tail'
    end

    # Tail logs
    def tail_cmd
      execute tail_cmd_str
    end
  end
end
