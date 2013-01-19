require 'gomon/dump'

module Noveku
  module Mongo
    # Heroku config keys name
    MONGOLAB_KEY = 'MONGOLAB_URI'
    MONGOHQ_KEY = 'MONGOHQ_URL'

    # Dump mongolab or mongohq db
    def mongodump_cmd
      uri = config_value_for(MONGOLAB_KEY) || config_value_for(MONGOHQ_KEY)

      mongo_dump uri
    end

    # Dump mongolab db
    def mongolab_dump_cmd
      mongo_dump config_value_for(MONGOLAB_KEY)
    end

    # Dump mongohq db
    def mongohq_dump_cmd
      mongo_dump config_value_for(MONGOHQ_KEY)
    end

    # Get a dump of the database
    def mongo_dump(uri)
      raise NoUriSupplied unless uri

      Gomon::Dump.new(uri: uri).call
    end
  end
end
