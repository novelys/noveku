module Noveku
  module Options
    def verbose?
      arguments.include?('--verbose')
    end

    def dry_run?
      arguments.include?('--dry-run')
    end

    def proxied_arguments
      arguments.reject { |a| %w(--verbose --dry-run).include?(a) }
    end
  end
end
