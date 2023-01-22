# frozen_string_literal: true

module Weather
  module Historical
    class Root < Grape::API
      desc 'Returns last 24 hours temperatures'
      get do
        { status: 'not implemented' }
      end

      desc 'Returns last 24 hours maximum temperature'
      get :max do
        { status: 'not implemented' }
      end

      desc 'Returns last 24 hours minimum temperature'
      get :min do
        { status: 'not implemented' }
      end

      desc 'Returns last 24 hours avg temperature'
      get :avg do
        { status: 'not implemented' }
      end
    end
  end
end
