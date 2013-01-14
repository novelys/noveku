module Noveku
  module Proxy
    # If this is a command with no specific support, pass the raw arguments to `heroku` directly
    def method_missing(name, *args, &block)
      if name.to_s.end_with?('_cmd')
        execute @commands.join(' ')
      else
        super
      end
    end
  end
end
