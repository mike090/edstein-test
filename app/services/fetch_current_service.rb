# frozen_string_literal: true

class FetchCurrentService
  class << self
    def call(location)
      data = AccuweatherAdapter.current(location)
      data.each do |t|
        record = TemperatureInfo.new(t)
        record.save
      end
    end
  end
end
