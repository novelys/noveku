module Noveku
  module Tail
    # Open the console
    def tail_cmd
      execute 'logs --tail'
    end
  end
end
