# frozen_string_literal: true

class AccuweatherAdapter
  class << self
    def current(location)
      path = "currentconditions/v1/#{location}"
      raw = request_remote path
      AccuweatherApiMapper.new.call(raw)
    end

    def last_24h(location)
      path = "currentconditions/v1/#{location}/historical/24"
      raw = request_remote path
      AccuweatherApiMapper.new.call(raw)
    end

    private

    def connection
      options =
        {
          url: 'http://dataservice.accuweather.com',
          headers:
          {
            accept: 'application/json',
            user_agent: 'ruby-client'
          }
        }
      @connection ||= Faraday.new(options) do |faraday|
        faraday.response :raise_error
      end
    end

    def request_remote(path)
      response = connection.get path, { apikey: ENV.fetch('ACCUWEATHER_API_KEY', nil) }
      JSON.parse response.body
    end
  end
end
