module Noveku
  class Staging < Base
    def initialize(commands)
      @environment = 'staging'
      super(commands)
    end
  end
end
