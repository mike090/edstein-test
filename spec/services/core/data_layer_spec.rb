# frozen_string_literal: true

RSpec.describe Core::DataLayer do
  fixtures :all

  let(:location) { ENV.fetch('LOCATION_KEY', nil) }

  describe '.current' do
    it 'returns last record by time' do
      t_info = described_class.current location
      last = TemperatureInfo.order(:time).last
      expect(t_info[:time].to_i).to eq(last.time)
    end
  end

  describe '.last_24h_min' do
    it 'returns min_value fixture' do
      t_info = described_class.last_24h_min location
      expect(t_info[:time].to_i).to eq temperature_infos(:min_value).time
    end
  end

  describe '.last_24h_max' do
    it 'returns max value fixture' do
      t_info = described_class.last_24h_max location
      expect(t_info[:time].to_i).to eq temperature_infos(:max_value).time
    end
  end

  describe '.last_24h_avg' do
    it 'returns avg value' do
      t_info = described_class.last_24h_avg location
      data = TemperatureInfo.where('time > ?', Time.now.ago(24.hours).to_i)
      expect(t_info[:avg_value]).to eq (data.sum(:value) / data.count).round(1)
    end
  end

  describe '.by_time' do
    it 'returns nearest value' do
      t_info = described_class.by_time location, Time.now.ago(3.minutes).to_i
      expect(t_info[:time].to_i).to eq(temperature_infos(:five_minutes_ago).time)
    end
  end

  describe '.last_24h' do
    it 'returns 24 items array' do
      data = described_class.last_24h location
      expect(data.count).to eq 24
    end

    it 'returned items times are nearest for beginning of hour' do
      data = described_class.last_24h location
      data.each do |i|
        min = Time.zone.at(i[:time]).min
        expect(min < 10 || min > 50).to be_truthy
      end
    end
  end
end
