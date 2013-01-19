module Noveku
  module Config
    def config_value_str(key)
      "config:get #{key}"
    end

    # Returns config value for key
    def config_value_for(key)
      cmd = executable_command config_value_str(key)
      value = `#{cmd}`.strip
      value = nil if value == ''
      value
    end
  end
end
