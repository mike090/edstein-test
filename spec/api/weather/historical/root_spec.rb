# frozen_string_literal: true

module Weather
  module Historical
    RSpec.describe Root do
      it 'has endpoint /weather/historical' do
        get '/weather/historical'
        expect(response.status).to eq 200
      end

      it 'has endpoint /weather/historical/min' do
        get '/weather/historical/min'
        expect(response.status).to eq 200
      end

      it 'has endpoint /weather/historical/max' do
        get '/weather/historical/max'
        expect(response.status).to eq 200
      end

      it 'has endpoint /weather/historical/avg' do
        get '/weather/historical/avg'
        expect(response.status).to eq 200
      end
    end
  end
end
