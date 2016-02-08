require 'BalanceRecord'

class Scenario
  attr_accessor :scenario_name, :balances, :vest_level

  def set_defaults
    @balances ||= [BalanceRecord.new()]
    @scenario_name ||= "NAME"
    @vest_level ||= 0
  end

  def initialize params = {}
    params.each { |key,value| instance_variable_set("@#{key}", value) }
    set_defaults
  end

  def day_calc bal_rec
    accounts = []
    balance = bal_rec.balance
    bal_rec.accounts.each do |val|
      new_account = val.acct_copy
      new_account.compound
      new_account.balance += new_account.bill(bal_rec.date)
      balance -= new_account.bill(bal_rec.date)
      accounts << new_account
    end
    BalanceRecord.new(date: bal_rec.date + 1, balance: balance, accounts: accounts)
  end

  def run(start_day, finish_day)
    bookmark = [0, finish_day]
    vest = 0
    if (start_day >= finish_day) then
      return
    end
    @balances.sort! #Usually does not need to be done, figure out how to get rid of this
    start_index = @balances.index { |balrec| balrec.date == start_day } || 0
    (finish_day - start_day).to_i.times do |i|
      @balances[start_index + i + 1] = day_calc @balances[start_index + i]
      puts @balances[start_index + i + 1]
      if ((i == 0 || @balances[start_index + i].balance < @vest_level) && @balances[start_index + i + 1].balance > @vest_level) then
        bookmark = [i + 1, @balances[start_index + i + 1].date]
        vest = @vest_level
      end
    end
    vest(start_index + bookmark[0], vest)
    run(bookmark[1], finish_day)
  end

  #Precondition: @balances.accounts is sorted in order they should be paid off
  def vest(index, amount)
    amt = amount
    leftover = amt
    if (amount <= 0 || @balances[index].accounts.last.balance >= 0) then
      return
    end
    @balances[index].accounts.each do |acct|
      if (acct.balance < 0) then
        leftover = acct.pay_with_leftover(amt)
        @balances[index].balance -= amt - leftover
        amt = vest(index, leftover)
      end
    end
    leftover
  end
end
