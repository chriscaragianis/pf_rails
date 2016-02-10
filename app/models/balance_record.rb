class BalanceRecord < ActiveRecord::Base
  include Comparable
  has_many :accounts
  belongs_to :scenario

  validates :date, presence: true
  validates :balance, presence: true
  
  def <=> other
    self.date <=> other.date
  end

end
