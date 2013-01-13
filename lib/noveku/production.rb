module Noveku
  class Production < Base
    def initialize(commands)
      @environment = 'production'
      super(commands)
    end
  end
end
