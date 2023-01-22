# frozen_string_literal: true

module Weather
  RSpec.describe Root do
    it 'has endpoint "current"' do
      get '/weather/current'
      expect(response.status).to eq 200
    end

    it 'has endpoint "by_time"' do
      get "/weather/by_time/#{1.hour.ago.to_i}"
      expect(response.status).to eq 200
    end
  end
end
