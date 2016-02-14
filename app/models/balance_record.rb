class BalanceRecord < ActiveRecord::Base
  include Comparable
  has_many :accounts
  belongs_to :scenario

  validates :date, presence: true
  validates :balance, presence: true
  
  def <=> other
    self.date <=> other.date
  end

  def to_s
    "Date: #{self.date}, Balance: #{self.balance}, Created: #{self.created_at}"
  end
end
