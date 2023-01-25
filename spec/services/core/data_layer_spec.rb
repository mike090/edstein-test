# frozen_string_literal: true

RSpec.describe Core::DataLayer do
  fixtures :all

  describe '.current' do
    it 'returns last record by time' do
      ti = described_class.current 1
      last = TemperatureInfo.order(:time).last
      expect(ti[:time].to_i).to eq(last.time)
    end
  end

  describe '.last_24h_min' do
    it 'returns min_value fixture' do
      ti = described_class.last_24h_min 1
      expect(ti[:time].to_i).to eq temperature_infos(:min_value).time
    end
  end

  describe '.last_24h_max' do
    it 'returns max value fixture' do
      ti = described_class.last_24h_max 1
      expect(ti[:time].to_i).to eq temperature_infos(:max_value).time
    end
  end

  describe '.last_24h_avg' do
    it 'returns avg value' do
      ti = described_class.last_24h_avg 1
      data = TemperatureInfo.where('time > ?', Time.now.ago(24.hours).to_i)
      expect(ti[:avg_value]).to eq (data.sum(:value) / data.count).round(1)
    end
  end

  describe '.by_time' do
    it 'returns nearest value' do
      ti = described_class.by_time 1, Time.now.ago(3.minutes).to_i
      expect(ti[:time].to_i).to eq(temperature_infos(:five_minutes_ago).time)
    end
  end

  describe '.last_24h' do
    it 'returns 24 items array' do
      data = described_class.last_24h 1
      expect(data.count).to eq 24
    end

    it 'returned items times are nearest for beginning of hour' do
      data = described_class.last_24h 1
      data.each do |i|
        min = Time.zone.at(i[:time]).min
        expect(min < 10 || min > 50).to be_truthy
      end
    end
  end
end