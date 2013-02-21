module Noveku
  module Config
    def config_value_str(key)
      "config:get #{key}"
    end

    # Returns config value for key
    def config_value_for(key)
      cmd = execute_heroku config_value_str(key), hide_stderr: true
      value = `#{cmd}`.strip
      value = nil if value == ''
      value
    end
  end
end
