# frozen_string_literal: true

class AccuweatherFetchService
  class << self
    def call(location)
      data = AccuweatherAdapter.last_24h(location)
      data.each do |t|
        t[:location] = location
        record = TemperatureInfo.new(t)
        record.save
      end
    rescue StandardError => e
      Rails.logger.error ['Error during data fetching: ', e.message, e.backtrace].join('\n')
    end
  end
end
