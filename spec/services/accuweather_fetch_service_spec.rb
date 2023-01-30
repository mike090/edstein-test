# frozen_string_literal: true

RSpec.describe AccuweatherFetchService do
  let(:new_weather_data) do
    [
      { time: 1_674_896_100, value: 25.0 },
      { time: 1_674_856_500, value: 27.2 }
    ]
  end

  before do
    allow(AccuweatherAdapter).to receive(:last_24h).and_return(new_weather_data)
  end

  context 'when adapter return new data' do
    it 'is saved at model' do
      before_count = TemperatureInfo.count
      described_class.call(123)
      expect(TemperatureInfo.count - before_count).to eq(new_weather_data.count)
    end
  end

  context 'when adapter return recurring data' do
    it "doesn't saved" do
      allow(AccuweatherAdapter).to receive(:last_24h).and_return(TemperatureInfo.first.attributes.slice('time', 'value'))
      before_count = TemperatureInfo.count
      described_class.call(TemperatureInfo.first.location)
      expect(TemperatureInfo.count).to eq(before_count)
    end
  end
end
