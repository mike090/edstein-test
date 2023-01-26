# frozen_string_literal: true

module Core
  class CacheLayer
    include Handler

    def initialize(expire_time)
      @expire_time = expire_time
    end

    def handle(msg, *args)
      Rails.cache.fetch("#{msg}/#{args.join(':')}", expires_in: @expire_time) do
        super
      end
    end
  end
end
