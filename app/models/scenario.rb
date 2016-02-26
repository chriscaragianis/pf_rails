class Scenario < ActiveRecord::Base
include ScenariosHelper

  has_many :balance_records

  validates :name, presence: true, length: { minimum: 2 }
  validates :vest_level, presence: true

  def run(start_date, finish_date)
    self.save
    create_balance_record_list(start_date + 1, finish_date)
    vest_date = finish_date
    vest_amount = 0
    if (start_date >= finish_date) then
      puts self.balance_records.all.map { |br| "#{br.date}, #{br.balance}" }
      return
    end
    (finish_date - start_date).to_i.times do |i|

      #This line uses date_calc to update the next balance_record
      #using the current balance_record

      #Supposedly balance_records have enforced uniqueness by scenario
      #Nonetheless, this...
      br_new = self.balance_records.where(date: start_date + i + 1).last
      br_old = self.balance_records.where(date: start_date + i).last
      br_new.update(day_calc(br_old))

      #This line checks for vesting and sets up vesting if needed
      if ((i == 0 || br_old.balance < self.vest_level) && br_new.balance > self.vest_level) then
        puts "WE SEENT IT #{start_date + i + 1}"
        vest_date = start_date + i + 1
        vest_amount = self.vest_level
      end
    end
    puts "AND IM OUT"
    self.balance_records.where(date: vest_date).last.vest(vest_amount)
    self.save
    run(vest_date, finish_date)
  end


  def create_balance_record_list(first_day, last_day)
    BalanceRecord.where(scenario_id: self.id, date: (first_day..(last_day))).delete_all
    index_day = first_day
    while (index_day <= last_day) do
      br = BalanceRecord.new(date: index_day, balance: 1.5, scenario_id: self.id)
      br.save
      self.balance_records << br
      index_day += 1
    end
    self.save
  end
end
