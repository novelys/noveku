module Noveku
  module Proxy
    # String to execute when proxying commands
    def proxy_cmd_str
      ([@command] + @arguments).join(' ')
    end

    # If this is a command with no specific support, pass the raw arguments to `heroku` directly
    def method_missing(name, *args, &block)
      if name.to_s.end_with?('_cmd')
        execute_heroku proxy_cmd_str
      else
        super
      end
    end

    # Expose proxying handling
    def respond_to_missing?(name, include_private)
      if name.to_s.end_with?('_cmd')
        true
      else
        super
      end
    end
  end
end
