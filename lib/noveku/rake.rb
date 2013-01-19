module Noveku
  module Rake
    # Rake command string
    def rake_cmd_str
      task = @arguments.join(' ')

      "run rake #{task}"
    end

    # Execute a rake task
    def rake_cmd
      execute rake_cmd_str
    end
  end
end
