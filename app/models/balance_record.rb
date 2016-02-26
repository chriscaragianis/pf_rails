class BalanceRecord < ActiveRecord::Base
  include Comparable
  has_many :accounts
  belongs_to :scenario

  validates :date, presence: true
  validates :balance, presence: true
  validates_uniqueness_of :date, scope: :scenario_id

  def <=> other
    self.date <=> other.date
  end

  def to_s
    "Date: #{self.date}, Balance: #{self.balance}, Created: #{self.created_at}"
  end

  def get_vest_list
    list = self.accounts.to_a
    list.delete_if { |acct| acct.balance >= 0 || !acct.carry_balance }
    list.sort! { |x,y| x.vest_priority <=> y.vest_priority }
  end

  def vest(amount)
    puts "VESTING Date: #{self.date} Amount: #{amount}"
    leftover = amount
    if (amount <= 0) then
      return leftover
    end
    get_vest_list.each do |acct|
      leftover = acct.pay(amount)
      self.balance -= amount - leftover
      acct.save
      self.save
      amount = vest(leftover)
    end
    leftover
  end
end
