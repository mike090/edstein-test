# frozen_string_literal: true

RSpec.describe Weather do
  fixtures :all

  it 'has endpoint "current"' do
    get '/weather/current'
    expect(response.status).to eq 200
  end

  it 'has endpoint "by_time"' do
    example = temperature_infos :max_value
    get "/weather/by_time/#{example.time + 90}"
    expect(response.status).to eq 200
  end
end
