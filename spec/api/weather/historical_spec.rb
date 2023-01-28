# frozen_string_literal: true

RSpec.describe Weather::Historical do
  context 'GET weather/historical'
  it 'returns 24 items array' do
    get '/weather/historical'
    expect(response.status).to eq 200
    data = JSON.parse response.body
    expect(data.count).to eq 24
    data.each { |t_info| expect(t_info.keys).to eq %w[location time value unit] }
  end

  context 'GET weather/historical/min'
  it 'returns temperature information' do
    get '/weather/historical/min'
    expect(response.status).to eq 200
    expect(JSON.parse(response.body).keys).to eq %w[location time value unit]
  end

  context 'GET weather/historical/max'
  it 'returns temperature information' do
    get '/weather/historical/max'
    expect(response.status).to eq 200
    expect(JSON.parse(response.body).keys).to eq %w[location time value unit]
  end

  context 'GET weather/historical/avg'
  it 'returns avg information' do
    get '/weather/historical/avg'
    expect(response.status).to eq 200
    expect(JSON.parse(response.body).keys).to eq %w[location from to avg_value unit]
  end
end
