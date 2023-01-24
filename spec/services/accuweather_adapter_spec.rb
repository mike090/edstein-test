# frozen_string_literal: true

RSpec.describe AccuweatherAdapter do
  specify '.current' do
    template = Addressable::Template.new 'http://dataservice.accuweather.com/currentconditions/v1/{location}?apikey={api_key}'
    stub_request(:get, template)
      .to_return(status: 200, body: file_fixture('current.json').read, headers: {})

    current_t = described_class.current 123
    expected_t = JSON.parse(file_fixture('current.json').read).map do |t|
      { time: t['EpochTime'], value: t.dig('Temperature', 'Metric', 'Value'), unit: t.dig('Temperature', 'Metric', 'Unit'), location: 123 }
    end
    expect(current_t).to eq(expected_t)
  end

  specify '.last_24h' do
    template = Addressable::Template.new 'http://dataservice.accuweather.com/currentconditions/v1/{location}/historical/24?apikey={api_key}'
    stub_request(:get, template)
      .to_return(status: 200, body: file_fixture('current.json').read, headers: {})

    current_t = described_class.last_24h 123
    expected_t = JSON.parse(file_fixture('current.json').read).map do |t|
      { time: t['EpochTime'], value: t.dig('Temperature', 'Metric', 'Value'), unit: t.dig('Temperature', 'Metric', 'Unit'), location: 123 }
    end
    expect(current_t).to eq(expected_t)
  end

  it 'raised DataNotAvailableError exception' do
    stub_request(:get, /.*/)
      .to_return(status: 401)
    expect { described_class.current 123 }.to raise_error AccuweatherAdapter::DataNotAvailableError
  end
end
