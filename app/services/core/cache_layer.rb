# frozen_string_literal: true

module Core
  class CacheLayer
    include Handler

    def initialize(expire_in_minutes)
      @expire_time = expire_in_minutes
    end

    def handle(msg, *args)
      Rails.cache.fetch("#{msg}/#{args.join(':')}", expires_in: @expire_time.minutes) do
        super
      end
    end
  end
end
