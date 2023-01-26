# frozen_string_literal: true

class Weather < Grape::API
  extend RequestProcessor

  desc 'Returns current temperature'
  # хотелось вынести повторяющийся код из блоков
  # возможно, существует более изящное решение, нежели извлечение блока из лямбды
  # думал над dsl, но ничего красивого в голову не пришло
  get :current, &return_answer_for(:current)

  desc 'Returns nearest temperature'
  params do
    requires :time_stamp, type: Integer, desc: 'Timestamp'
  end
  get '/by_time/:time_stamp', &return_answer_for(:by_time, :time_stamp)

  namespace :historical do
    mount Historical
  end
end
