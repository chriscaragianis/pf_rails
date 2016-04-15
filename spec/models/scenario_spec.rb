require 'rails_helper'
require 'balance_record'

RSpec.describe Plan, type: :model do
  before(:each) do
    DatabaseCleaner.start
    @scene = create(:plan, vest_level: 1050)
    @bal_rec = BalanceRecord.new(date: Date.new(2016,2,3), balance: 1000)
    @car = create(:account, acct_name: "CAR", carry_balance: true, rate: 0.06, balance: -5500, day: 5, fixed_amount: 300)
    @pay = create(:account, acct_name: "PAY", balance: 0,  weekly: true, week_period: 1, week_offset: 0, day: 5, fixed_amount: -200)
    @bal_rec.accounts = [@pay, @car]
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  it "should be valid" do
    expect(@scene).to be_valid
  end

  it "should have a name" do
    @scene.update(name: nil)
    expect(@scene).not_to be_valid
  end

  it "should have a non-blank name" do
    @scene.update(name: "   ")
    expect(@scene).not_to be_valid
  end

  it "should have a non-short name" do
    @scene.update(name: "x")
    expect(@scene).not_to be_valid
  end

  it "#run should produce a correct single day" do
    @scene.balance_records << @bal_rec
    @scene.run(Date.new(2016,2,3), Date.new(2016,2,4))

    br = @scene.balance_records.select {|brec| brec.date == Date.new(2016,2,4)}.last
    expect(@scene.balance_records.last.date).to eq(Date.new(2016,2,4))
    expect(@scene.balance_records.count).to eq(2)
    expect(br.balance).to eq(1000)
    expect(br.accounts.select {|acct| acct.acct_name == "CAR"}.last.balance).to  eq(-5500 - 5500*0.06/365)
  end

  it "#run should vest when appropriate" do
    @scene.balance_records << @bal_rec
    @scene.run(Date.new(2016,2,3), Date.new(2016,2,20))
    br = @scene.balance_records.select { |bal_rec| bal_rec.date == Date.new(2016, 2, 13) }
    expect(br.last.balance).to eq(50)
    expect(@scene.balance_records.count).to eq(18)
  end

end
