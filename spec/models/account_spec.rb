require 'rails_helper'

def account_with_all
  Account.new(acct_name: "test account",
              rate: 0.06,
              balance: -1000,
              min_rate: -0.02,
              weekly: false,
              week_offset: 0,
              week_period: 0,
              day: 5,
              fixed_amount: 0,
              carry_balance: false
              )
end

RSpec.describe Account, type: :model do
  before(:each) do
    @acct = account_with_all
  end

  it "should be valid" do
    expect(@acct).to be_valid
  end

  it "has a day" do
    @acct.update(day: nil)
    expect(@acct).not_to be_valid
  end

  it "has a min_rate" do 
    @acct.update(min_rate: nil)
    expect(@acct).not_to be_valid
  end

  it "is valid weekly if week_period and week_offset are correct" do
    @acct.update(weekly: true, week_offset: 0, week_period: 1)
    expect(@acct).to be_valid
  end

  it "has week_period if weekly" do
    @acct.update(weekly: true, week_period: nil)
    expect(@acct).not_to be_valid
  end

  it "has week_offset if weekly" do
    @acct.update(weekly: true, week_offset: nil)
    expect(@acct).not_to be_valid
  end

  it "has valid week_offset" do
    @acct.update(weekly: true, week_offset: 2, week_period: 2)
    expect(@acct).not_to be_valid
  end

  it "has balance if carry_balance" do
    @acct.update(carry_balance: true, balance: nil)
    expect(@acct).not_to be_valid
  end

  it "has rate if carry_balance" do
    @acct.update(carry_balance: true, rate: nil)
    expect(@acct).not_to be_valid
  end

  it "#to_s formats correctly as a string" do
    expect(@acct.to_s).to eq("Name: test account, Balance: -1000.0")
  end

  it "#bill sends a weekly bill correctly" do
    @acct.update(weekly: true, week_period: 1, week_offset: 0)
    expect(@acct.bill(Date.new(2016, 2, 8))).to eq(0)
    expect(@acct.bill(Date.new(2016, 2, 12))).to eq(20)
  end

  it "#bill sends a monthly bill correctly" do
    expect(@acct.bill(Date.new(2016, 2, 8))).to eq(0)
    expect(@acct.bill(Date.new(2016, 2, 5))).to eq(20)
  end
  
  it "#amount returns the balance if less than fixed amount" do
    @acct.update(fixed_amount: 2000)
    expect(@acct.amount).to eq(1000)
  end

  it "#amount returns the fixed_amount if the min_rate*balance is too small" do
    @acct.update(fixed_amount: 100)
    expect(@acct.amount).to eq(100)
  end

  it "#amount returns the min_rate*balance if large enough" do
    expect(@acct.amount).to eq(20)
  end

  it "#compund compounds if carry_balance" do
    @acct.update(carry_balance: true)
    @acct.compound
    expect(@acct.balance).to eq(-1000 + -1000 * 0.06 / 365)
  end

  it "#compond zeroes balance if not carry_balance" do
    @acct.compound
    expect(@acct.balance).to eq(0)
  end
end


