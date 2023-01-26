# frozen_string_literal: true

class Weather::Historical < Grape::API
  extend RequestProcessor

  desc 'Returns last 24 hours temperatures'
  get '/', return_answer_for(:last_24h)

  desc 'Returns last 24 hours maximum temperature'
  get :max, return_answer_for(:last_24h_max)

  desc 'Returns last 24 hours minimum temperature'
  get :min, return_answer_for(:last_24h_min)

  desc 'Returns last 24 hours avg temperature'
  get :avg, return_answer_for(:last_24h_avg)
end
