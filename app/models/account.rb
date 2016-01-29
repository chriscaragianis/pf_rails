class Account < ActiveRecord::Base

  def to_s
    return "Name: #{self.acct_name}, Balance: #{self.balance}"
  end

  def set_defaults
    self.rate ||= 0
    self.balance ||= 0
    self.min_floor ||= 0
    self.min_rate ||= 0
    self.acct_name ||= "NAME"
    self.weekly ||= 0
    self.week_offset ||= 0
    self.week_period ||= 0
    self.day ||= 0
    self.fixed_amount ||= 0
    self.carry_balance ||= true
  end

  def acct_copy
    Account.new(fixed_amount: self.fixed_amount, balance: self.balance, day: self.day, min_floor: self.min_floor,
                min_rate: self.min_rate, weekly: self.weekly, week_offset: self.week_offset,
                week_period: self.week_period, rate: self.rate, acct_name: self.acct_name)
  end

  def compound
    if (self.carry_balance)
      self.balance += self.balance * self.rate/365
    else
      self.balance = 0
    end
  end

  def bill (date)
    (self.weekly) ? weekly_bill(date) : monthly_bill(date)
  end

  def weekly_bill (date)
    (date.cweek % self.week_period == self.week_offset && date.cwday == self.day) ? self.amount : 0
  end

  def monthly_bill (date)
    (date.day == self.day) ? self.amount : 0
  end

  def amount
    if (self.balance.abs < self.min_floor) then
      return self.balance.abs
    else
      (self.fixed_amount == 0) ? [self.min_rate * self.balance, self.min_floor].max : self.fixed_amount
    end
  end

  def pay_with_leftover amt
    diff = amt + self.balance
    if (diff > 0) then
      self.balance = 0
      return diff
    else
      self.balance = diff
      return 0
    end
  end

  after_initialize { set_defaults }
end
