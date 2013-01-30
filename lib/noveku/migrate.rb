module Noveku
  module Migrate
    # Migrate args
    def migrate_cmd_args
      ['run rake db:migrate', 'restart']
    end

    # Open the console
    def migrate_cmd
      execute_heroku *migrate_cmd_args
    end
  end
end
