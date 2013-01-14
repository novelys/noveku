module Noveku
  module Config
    # Returns config value for key
    def config_value_for(key)
      cmd = executable_command("config:get #{key}")
      uri = `#{cmd}`.strip
      uri = nil if uri == ''
      uri
    end
  end
end
