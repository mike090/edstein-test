# frozen_string_literal: true

RSpec.describe Weather do
  fixtures :all

  context 'GET weather/current'
  it 'returns temperature information' do
    get '/weather/current'
    expect(response.status).to eq 200
    expect(JSON.parse(response.body).keys).to eq %w[location time value unit]
  end

  context 'GET weather/by_time'
  it 'return temperature information when data exists' do
    example = temperature_infos :max_value
    get "/weather/by_time/#{example.time + 90}"
    expect(response.status).to eq 200
    expect(JSON.parse(response.body).keys).to eq %w[location time value unit]
  end

  it 'returns 404 when data deosnt exists' do
    get "/weather/by_time/#{Time.now.ago(5.days).to_i}"
    expect(response.status).to eq 404
    expect(JSON.parse(response.body).keys).to eq %w[code message]
  end
end
