module Noveku
  module Migrate
    # Open the console
    def migrate_cmd
      execute 'run rake db:migrate', 'restart'
    end
  end
end
