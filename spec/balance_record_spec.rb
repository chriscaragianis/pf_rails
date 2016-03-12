require 'rails_helper'
require 'balance_record'

RSpec.describe BalanceRecord, type: :model do
  before(:each) do
    DatabaseCleaner.start
    @brecord = BalanceRecord.new(balance: 1000)
    @car = create(:account, acct_name: "CAR", carry_balance: true, rate: 0.06, balance: -5500, day: 5, fixed_amount: 300)
    @pay = create(:account, acct_name: "PAY", balance: 0,  weekly: true, week_period: 1, week_offset: 0, day: 5, fixed_amount: -200)
    @brecord.accounts = []
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  it "#get_vest_list removes account with !carry_balance" do
    @brecord.accounts << create(:account, carry_balance: true, balance: -1)
    @brecord.accounts << create(:account, carry_balance: false, balance: -1)
    expect(@brecord.get_vest_list.length).to eq(1)
  end

  it "#get_vest_list removes account with >= 0 balance" do
    @brecord.accounts << create(:account, carry_balance: true, balance: 1)
    @brecord.accounts << create(:account, carry_balance: true, balance: 0)
    @brecord.accounts << create(:account, carry_balance: true, balance: -10)
    expect(@brecord.get_vest_list.length).to eq(1)
  end

  it "#get_vest_list sorts remainder by vest_priority" do
    @brecord.accounts << create(:account, carry_balance: true, balance: -1, vest_priority: 1)
    @brecord.accounts << create(:account, carry_balance: true, balance: -20, vest_priority: 0)
    @brecord.accounts << create(:account, carry_balance: true, balance: -10, vest_priority: 2)
    expect(@brecord.get_vest_list.first.balance).to eq(-20)
    expect(@brecord.get_vest_list.last.balance).to eq(-10)
  end

it "#vest does nothing if amount is zero" do
    @brecord.accounts << @car
    @brecord.accounts << @pay
    @brecord.vest(0)
    expect(@brecord.balance).to eq(1000)
    expect(@brecord.accounts.select {|acct| acct.acct_name == "CAR" }.last.balance).to eq(-5500)
  end

  it "#vest pays the highest priority bill" do
    @brecord.accounts << @car
    @brecord.accounts << @pay
    @brecord.accounts << create(:account, carry_balance: true, balance: -100, vest_priority: -1)
    @brecord.vest(100)
    expect(@brecord.balance).to eq(900)
    expect(@brecord.accounts.select {|acct| acct.acct_name == "CAR" }.last.balance).to eq(-5500)
    expect(@brecord.accounts.select { |acct| acct.acct_name == "MyString"}.last.balance).to eq(0)
  end

end

RSpec.describe BalanceRecord, "#<=>" do
  before(:each) do
    @old = BalanceRecord.new(date: Date.today, balance: 0)
    @new = BalanceRecord.new(date: Date.today + 1, balance: 0)
  end

  it "orders BalanceRecords properly" do
    expect(@new).to be > @old
  end
end
