require 'rails_helper'

RSpec.describe Scenario, type: :model do
  before(:each) do
    DatabaseCleaner.clean	
    @scene = build(:scenario, vest_level: 1100)
    @bal_rec = create(:balance_record, date: Date.new(2016,2,1), balance: 1000)
    @car = create(:account, carry_balance: true, rate: 0.06, balance: -5500, day: 5, fixed_amount: 300)
    @pay = create(:account, weekly: true, week_period: 1, week_offset: 0, day: 5, fixed_amount: -200)
    @bal_rec.accounts = [@car, @pay]
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
    @scene.run(Date.new(2016,2,1), Date.new(2016,2,2))
    expect(@scene.balance_records.last.date).to eq(Date.new(2016,2,2))
    expect(@scene.balance_records.count).to eq(2)
    expect(@bal_rec.balance).to eq(1000)
    expect(@scene.balance_records.last.accounts[0].balance).to eq(-5500 - 5500*0.06/365)
  end
  
  it "#run should vest when appropriate" do
      
  #it "#run should not vest when not appropriate"
  end
end
