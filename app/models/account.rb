class AccountValidator < ActiveModel::Validator
  def validate(acct)
    if acct.weekly && acct.week_offset && acct.week_period then
      unless acct.week_offset >= 0 && acct.week_offset < acct.week_period
        acct.errors[:week_offset] << "Bad week offset"
      end
    end
  end
end

class Account < ActiveRecord::Base
  belongs_to :user
  has_many :scene_accounts
  has_many :scencarios, :through => :scene_accounts
  validates :day, presence: true
  validates :min_rate, presence: true
  validates :fixed_amount, presence: true

  validates :week_offset, presence: true, if: :weekly?
  validates :week_period, presence: true, if: :weekly?
  validates_with AccountValidator

  validates :balance, presence: true, if: :carry_balance?
  validates :rate, presence: true, if: :carry_balance?
  validates :vest_priority, presence: true, if: :carry_balance?

  def to_s
    return "Name: #{self.acct_name}, Balance: #{self.balance}"
  end

  def acct_copy
    Account.new(
      fixed_amount: self.fixed_amount,
      balance: self.balance,
      day: self.day,
      min_rate: self.min_rate,
      weekly: self.weekly,
      week_offset: self.week_offset,
      week_period: self.week_period,
      rate: self.rate,
      acct_name: self.acct_name,
      carry_balance: self.carry_balance,
      vest_priority: self.vest_priority
    )
  end

  def compound
    if (self.carry_balance)
      self.balance += self.balance * self.rate/365
    else
      self.balance = 0
    end
  end

  def bill(date)
    (self.weekly) ? weekly_bill(date) : monthly_bill(date)
  end

  def weekly_bill(date)
    (date.cweek % self.week_period == self.week_offset &&
      date.cwday == self.day) ?
    self.amount : 0
  end

  def monthly_bill(date)
    (date.day == self.day) ? self.amount : 0
  end

  def amount
    unless (self.fixed_amount < 0) then
      if (self.balance.abs < self.fixed_amount) then
        self.balance.abs
      else
        [self.min_rate * balance, self.fixed_amount].max
      end
    else
      self.fixed_amount
    end
  end

  def pay(amt)
    diff = amt + self.balance
    if (diff > 0) then
      self.balance = 0
      diff
    else
      self.balance = diff
      0
    end
  end

end
