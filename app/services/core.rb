# frozen_string_literal: true

module Core
  extend Handler

  CACHE_EXPIRE_TIME = 5

  def self.handle(msg, *args)
    begin
      status = 200
      body = super
    rescue DataNotAvailableError
      status = 404
      body = { code: 404, message: 'not found' }
    rescue NotImplementedError
      status = '404'
      body = { code: 404, message: 'not implemented' }
    end

    [status, body]
  end

  cache = CacheLayer.new CACHE_EXPIRE_TIME
  cache.plug_on DataLayer
  plug_on cache

  class DataNotAvailableError < RuntimeError; end
  class NotImplementedError < RuntimeError; end
end
