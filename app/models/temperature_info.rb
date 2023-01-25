# frozen_string_literal: true

class TemperatureInfo < ApplicationRecord
  validates :location, presence: true
  validates :time, presence: true
  validates :value, presence: true

  validates :time, uniqueness: { scope: :location }

  scope :by_location, ->(location) { where location: location }
  scope :ago, ->(duration) { where 'time > ?', Time.now.ago(duration).to_i }
  scope :between, ->(after, before) { where 'time BETWEEN ? AND ?', after, before }
end
