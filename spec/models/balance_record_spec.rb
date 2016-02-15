require 'rails_helper'

RSpec.describe BalanceRecord, type: :model do
  before(:each) do
    DatabaseCleaner.clean
    @brecord = build(:balance_record)
  end

  it "should be valid" do
    expect(@brecord).to be_valid
  end

  it "has a date" do
    @brecord.update(date: nil)
    expect(@brecord).not_to be_valid
  end

  it "has a balance" do
    @brecord.update(balance: nil)
    expect(@brecord).not_to be_valid
  end

  it "validates associated records" do
    acct = build(:account, day: nil)
    @brecord.accounts << acct
    expect(@brecord).not_to be_valid
  end

  it "has unique date in scenario scope" do
    scene = create(:scenario)
    br1 = create(:balance_record, date: Date.today)
    scene.balance_records << br1
    br2 = create(:balance_record, date: Date.today)
    expect(br1).to be_valid
    scene.balance_records << br2
    expect(br2).not_to be_valid
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
