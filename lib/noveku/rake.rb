module Noveku
  module Rake
    # Execute a rake task
    def rake_cmd
      task = @commands[1..-1].join(' ')

      execute "run rake #{task}"
    end
  end
end
