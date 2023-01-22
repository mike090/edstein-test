# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiRoot do
  it 'has /health entrypoint' do
    get '/health'
    expect(response.status).to eq 200
  end
end
