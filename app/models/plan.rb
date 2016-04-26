require 'balance_record'

class Plan < ActiveRecord::Base
include PlansHelper
include Comparable
  attr_accessor :balance_records
  belongs_to :user
  has_many :plan_accounts
  has_many :accounts, :through => :plan_accounts

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
    Accounts.to_a.each do |acct|
      if acct.user_id == current_user.id
        br.accounts[acct.id] = acct
        debugger
      end
    end
    br.balance = self.start_balance
    br.date = date
    @balance_records << br
  end

  def run(start_date, finish_date)
    date_stack = []
    @balance_records.sort!
    @balance_records.select!{ |br| br.date <= start_date }

    vest_date = finish_date
    vest_amount = 0
    if (start_date >= finish_date) then
      return
    end
    (finish_date - start_date).to_i.times do |i|
      br_old = @balance_records.select{ |br| br.date == start_date + i }.last
      br_new = day_calc(br_old)
      @balance_records << br_new
      #This line checks for vesting and sets up vesting if needed
      if ((i == 0 || br_old.balance < self.vest_level) && br_new.balance > self.vest_level) then
        date_stack.push(start_date + i + 1)
        br_new.vest(self.vest_level)
      end
      if (br_new.balance < 0) then
        run(date_stack.pop, finish_date)
        return
      end 
    end
  end

end
