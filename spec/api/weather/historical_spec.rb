# frozen_string_literal: true

RSpec.describe Weather::Historical do
  let(:expected_keys) { %w[location time value unit] }

  context 'GET weather/historical'
  it 'returns 24 items array of hashs with specific keys' do
    get '/weather/historical'
    expect(response.status).to eq 200
    data = JSON.parse response.body
    expect(data.count).to eq 24
    data.each { |t_info| expect(t_info.keys - expected_keys).to eq [] }
  end

  context 'GET weather/historical/min'
  it 'returns temperature information with specific keys' do
    get '/weather/historical/min'
    expect(response.status).to eq 200
    expect(JSON.parse(response.body).keys - expected_keys).to eq []
  end

  context 'GET weather/historical/max'
  it 'returns temperature information with specific keys' do
    get '/weather/historical/max'
    expect(response.status).to eq 200
    expect(JSON.parse(response.body).keys - expected_keys).to eq []
  end

  context 'GET weather/historical/avg'
  it 'returns avg information' do
    get '/weather/historical/avg'
    expect(response.status).to eq 200
    expect(JSON.parse(response.body).keys - %w[location from to avg_value unit]).to eq []
  end
end
