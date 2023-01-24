# frozen_string_literal: true

module Core
  class DataLayer
    class << self
      def last_24h_max(location)
        t_info = TemperatureInfo.by_location(location).ago(24.hours).order(:value).last
        if t_info
          return {
            location: t_info.location,
            time: Time.zone.at(t_info.time),
            value: t_info.value,
            unit: t_info.unit
          }
        end

        raise DataNotAvailableError, 'Data not available'
      end

      def last_24h_min(location)
        t_info = TemperatureInfo.by_location(location).ago(24.hours).order(:value).first
        if t_info
          return {
            location: t_info.location,
            time: Time.zone.at(t_info.time),
            value: t_info.value,
            unit: t_info.unit
          }
        end

        raise DataNotAvailable, 'Data not available'
      end

      def last_24h_avg(location)
        data = TemperatureInfo.by_location(location).ago(24.hours).order(:time)
        raise DataNotAvailableError, 'Data not available' if data.empty?

        avg = data.sum(&:value) / data.count
        {
          from: Time.zone.at(data.first.time),
          to: Time.zone.at(data.last.time),
          avg_value: avg.round(1),
          unit: 'C'
        }
      end

      def by_time(location, time)
        # +-10 минут
        after = time - 10.minutes.to_i
        before = time + 10.minutes.to_i
        data = TemperatureInfo.by_location(location).between(after, before)
        raise DataNotAvailableError, 'Data not available' if data.empty?

        t_info = data.min { |item1, item2| (item1.time - time).abs <=> (item2.time - time).abs }
        {
          location: t_info.location,
          time: Time.zone.at(t_info.time),
          value: t_info.value,
          unit: t_info.unit
        }
      end

      def current(location)
        by_time location, Time.now.to_i
      end

      def last_24h(location)
        start = Time.zone.now.beginning_of_hour
        hours = (0..23).map { |i| (start - i.hour).to_i }
        hours.map do |time|
          by_time location, time
        rescue DataNotAvailableError
          {
            location: location,
            time: Time.zone.at(time),
            value: nil,
            unit: 'C'
          }
        end
      end
    end
  end
end
