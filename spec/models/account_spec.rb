require 'rails_helper'

def account_with_all
  Account.new(acct_name: "test account",
              rate: 0.06,
              balance: -1000,
              min_floor: 200,
              min_rate: 0.02,
              weekly: false,
              week_offset: 0,
              week_period: 0,
              day: 0,
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
end

RSpec.describe Account, "#to_s" do
  it "formats correctly as a string" do
    acct = account_with_all
    expect(acct.to_s).to eq("Name: test account, Balance: -1000.0")
  end
end
