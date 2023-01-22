# frozen_string_literal: true

RSpec.describe ApiRoot do
  it 'has entrypoint /health' do
    get '/health'
    expect(response.status).to eq 200
  end
end
