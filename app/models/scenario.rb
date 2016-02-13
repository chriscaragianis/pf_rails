class Scenario < ActiveRecord::Base
include ScenarioHelper

  has_many :balance_records

  validates :name, presence: true, length: { minimum: 2 }
  validates :vest_level, presence: true

  def run(start_day, finish_day)
    bookmark = [0, finish_day]
    vest_amount = 0
    if (start_day >= finish_day) then
      self.save

####
      self.balance_records.each do |br|
        puts "\n#{br.date}, #{br.balance}: *****"
        br.accounts.each {|acct| puts "\t#{acct}" }
      end
####

      return
    end
    start_index = self.balance_records.index { |balrec| balrec.date == start_day } || 0
    (finish_day - start_day).to_i.times do |i|
      self.balance_records << day_calc(self.balance_records[start_index + i])
      if ((i == 0 || self.balance_records[start_index + i].balance < self.vest_level) && self.balance_records[start_index + i + 1].balance > self.vest_level) then
        bookmark = [i + 1, self.balance_records[start_index + i + 1].date]
        vest_amount = self.vest_level
      end
    end
    vest(start_index + bookmark[0], vest_amount)
    run(bookmark[1], finish_day)
  end

  def vest(index, amount)
    amt = amount
    leftover = amt
    if (amount <= 0 || self.balance_records[index].accounts.last.balance >= 0) then
      return
    end
    self.balance_records[index].accounts.each do |acct|
      if (acct.balance < 0) then
        leftover = acct.pay(amt)
        self.balance_records[index].balance -= amt - leftover
        amt = vest(index, leftover)
      end
    end
    leftover
  end
end
