class BalanceRecord
  include Comparable
  attr_accessor :accounts, :date, :balance

  def set_defaults
    @date ||= Date.today
    @balance ||= 0
    @accounts ||= []
  end

  def initialize params = {}
    params.each { |key,value| instance_variable_set("@#{key}", value) }
    set_defaults
  end

  def <=> other
    self.date <=> other.date
  end

  def to_s
    "Date: #{self.date}, Balance: #{self.balance}"
  end

  def get_vest_list
    vest_list = []
    @accounts.each do |acct|
      if (acct.carry_balance && acct.balance < 0) then
        vest_list << acct
      end
    end
    vest_list.sort {|a,b| a.vest_priority <=> b.vest_priority }
  end

  def vest(amount)
    leftover = amount
    if (amount <= 0) then
      return leftover
    end
    get_vest_list.each do |acct|
      leftover = acct.pay(amount)
      @balance -= amount - leftover
      amount = vest(leftover)
    end
    leftover
  end
end
