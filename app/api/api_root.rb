# frozen_string_literal: true

class ApiRoot < Grape::API
  format :json

  desc 'Returns service status'
  get :health do
    { status: 200, message: "I'm ok" }
  end

  namespace :weather do
    mount Weather
  end
end
