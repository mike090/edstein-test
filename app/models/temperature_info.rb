# frozen_string_literal: true

class TemperatureInfo < ApplicationRecord
  validates :time, uniqueness: { scope: :location }

  scope :by_location, ->(location) { where location: location }
  scope :ago, ->(duration) { where 'time > ?', Time.now.to_i - duration }
  scope :between, ->(after, before) { where 'time BETWEEN ? AND ?', after, before }
end
