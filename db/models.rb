require_relative "connection"

class Account < ActiveRecord::Base
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :snipers
end

class Sniper < ActiveRecord::Base
  validates :instrument, presence: true
  validates :timeframe, presence: true
  validates :expression, presence: true
  validates :quantity, presence: true

  scope :account, -> (account_id) { where(account: account_id) }
  scope :instrument, -> (instrument) { where(instrument: instrument) }
  belongs_to :account
end

class EconomicCalendar < ActiveRecord::Base
  validates :start, presence: true
  validates :description, presence: true
end
