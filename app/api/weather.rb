# frozen_string_literal: true

class Weather < Grape::API
  extend RequestProcessor

  desc 'Returns current temperature'
  get :current, return_answer_for(:current)

  desc 'Returns nearest temperature'
  params do
    requires :time_stamp, type: Integer, desc: 'Timestamp'
  end
  get '/by_time/:time_stamp', return_answer_for(:by_time, :time_stamp)

  namespace :historical do
    mount Historical
  end
end
