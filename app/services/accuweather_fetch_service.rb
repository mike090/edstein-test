# frozen_string_literal: true

class AccuweatherFetchService
  class << self
    def call(location)
      data = AccuweatherAdapter.last_24h(location)
      data.each do |t|
        record = TemperatureInfo.new(t)
        record.save
      end
    end
  end
end
