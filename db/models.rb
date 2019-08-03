require_relative "connection"

class Sniper < ActiveRecord::Base
  validates :instrument, presence: true
  validates :timeframe, presence: true
  validates :expression, presence: true
  validates :quantity, presence: true

  scope :instrument, -> (instrument) { where(instrument: instrument) }
end
