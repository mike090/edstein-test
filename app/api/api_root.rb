# frozen_string_literal: true

class ApiRoot < Grape::API
  format :json

  desc 'Returns service status'
  get :health do
    { status: 'ok' }
  end

  namespace :weather do
    mount Weather::Root
  end
end
