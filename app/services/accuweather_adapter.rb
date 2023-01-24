# frozen_string_literal: true

class AccuweatherAdapter
  class << self
    def current(location)
      path = "currentconditions/v1/#{location}"
      raw = request_remote path
      raw.map do |data|
        {
          location: location,
          time: data['EpochTime'],
          unit: data.dig('Temperature', 'Metric', 'Unit'),
          value: data.dig('Temperature', 'Metric', 'Value')
        }
      end
    end

    def last_24h(location)
      path = "currentconditions/v1/#{location}/historical/24"
      raw = request_remote path
      raw.map do |data|
        {
          location: location,
          time: data['EpochTime'],
          unit: data.dig('Temperature', 'Metric', 'Unit'),
          value: data.dig('Temperature', 'Metric', 'Value')
        }
      end
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
      begin
        response = connection.get path, { apikey: ENV.fetch('ACCUWEATHER_API_KEY', nil) }
      rescue StandardError => e
        message = e.is_a?(Faraday::ClientError) ? 'Accuweather service error' : 'Accuweather service unavailable'
        raise DataNotAvailableError, message
      end
      JSON.parse response.body
    end
  end

  class DataNotAvailableError < RuntimeError; end
end
