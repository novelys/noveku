module Noveku
  module Addon
    # Command string to add an addon
    def addon_cmd_str(name)
      "addons:add #{name}"
    end

    # Command string to list addons for current env
    def raw_list_addons_str
      "addons"
    end

    # Get the raw list of addons
    def raw_list_addons
      heroku = get_heroku raw_list_addons_str

      `#{heroku.command}`
    end

    # Clean the list of addons
    def cleaned_addons_list
      return @addons if @addons

      @addons = raw_list_addons.split("\n")
      @addons.reject! { |addon| addon.start_with?('===') }
      @addons.map! { |addon| addon.split(' ').first }
      @addons.uniq!
      @addons
    end
  end
end
