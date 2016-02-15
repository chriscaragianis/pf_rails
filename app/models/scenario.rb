class Scenario < ActiveRecord::Base
include ScenarioHelper

  has_many :balance_records

  validates :name, presence: true, length: { minimum: 2 }
  validates :vest_level, presence: true

  def run(start_date, finish_date)
    self.save
    create_balance_record_list(start_date + 1, finish_date)
    vest_date = finish_date
    vest_amount = 0
    if (start_date >= finish_date) then

      return
    end
    (finish_date - start_date).to_i.times do |i|

      #This line uses date_calc to update the next balance_record
      #using the current balance_record
      self.balance_records.where(date: start_date + i + 1).last.update(day_calc(self.balance_records.where(date: start_date + i).last))

      #This line checks for vesting and sets up vesting if needed
      if ((i == 0 || self.balance_records.where(date: start_date + i).last.balance < self.vest_level) && self.balance_records.where(date: start_date + i + 1).last.balance > self.vest_level) then
        vest_date = start_date + i + 1
        vest_amount = self.vest_level
      end
    end
    vest(vest_date, vest_amount)
    run(vest_date, finish_date)
  end

  def vest(day, amount)
    amt = amount
    leftover = amt
    if (amount <= 0 || self.balance_records.where(date: day).last.accounts.last.balance >= 0) then
      return
    end
    self.balance_records.where(date: day).last.accounts.each do |acct|
      if (acct.balance < 0) then
        leftover = acct.pay(amt)
        self.balance_records.where(date: day).last.balance -= amt - leftover
        amt = vest(index, leftover)
      end
    end
    leftover
  end

  def create_balance_record_list(first_day, last_day)
    BalanceRecord.where(scenario_id: self.id, date: (first_day..(last_day))).delete_all
    index_day = first_day
    while (index_day <= last_day) do
      self.balance_records << FactoryGirl.create(:balance_record, date: index_day, scenario_id: self.id)
      index_day += 1
    end
    self.save
  end
end
