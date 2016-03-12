require 'balance_record'

class Scenario < ActiveRecord::Base
include ScenariosHelper
include Comparable
  attr_accessor :balance_records
  has_many :accounts

  validates :name, presence: true, length: { minimum: 2 }
  validates :vest_level, presence: true

  after_initialize do 
    @balance_records = []
  end

  def <=> other
    self.vest_priority <=> other.vest_priority
  end

  def set_up_br(date)
    br = BalanceRecord.new
    self.accounts.to_a.each {|acct| br.accounts[acct.id] = acct }
    br.balance = self.start_balance
    br.date = date
    @balance_records << br
  end

  def run(start_date, finish_date)
    @balance_records.sort!
    @balance_records.select!{ |br| br.date <= start_date }

    vest_date = finish_date
    vest_amount = 0
    if (start_date >= finish_date) then
      puts @balance_records.each.map { |br| "#{br.date}, #{br.balance}" }
      return
    end
    (finish_date - start_date).to_i.times do |i|
      br_old = @balance_records.select{ |br| br.date == start_date + i }.last
      br_new = day_calc(br_old)
      @balance_records << br_new
      #This line checks for vesting and sets up vesting if needed
      if ((i == 0 || br_old.balance < self.vest_level) && br_new.balance > self.vest_level) then
        vest_date = start_date + i + 1
        vest_amount = self.vest_level
      end
    end
    @balance_records.select { |br| br.date ==  vest_date }.last.vest(vest_amount)
    run(vest_date, finish_date)
  end

end
