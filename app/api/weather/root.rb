# frozen_string_literal: true

module Weather
  class Root < Grape::API
    desc 'Returns current temperature'
    get :current do
      { status: 'not implemented' }
    end

    desc 'Returns nearest temperature'
    params do
      requires :time_stamp, type: Integer, desc: 'Timestamp'
    end
    get '/by_time/:time_stamp' do
      { status: 'not implemented' }
    end

    namespace :historical do
      mount Historical::Root
    end
  end
end
