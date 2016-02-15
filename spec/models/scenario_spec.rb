require 'rails_helper'

RSpec.describe Scenario, type: :model do
  before(:each) do
    DatabaseCleaner.start
    @scene = create(:scenario, vest_level: 1050)
    @bal_rec = create(:balance_record, date: Date.new(2016,2,3), balance: 1000)
    @car = create(:account, acct_name: "CAR", carry_balance: true, rate: 0.06, balance: -5500, day: 5, fixed_amount: 300)
    @pay = create(:account, acct_name: "PAY", weekly: true, week_period: 1, week_offset: 0, day: 5, fixed_amount: -200)
    @bal_rec.update(accounts:  [@pay, @car])
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
    expect(@scene.balance_records.last.date).to eq(Date.new(2016,2,4))
    expect(@scene.balance_records.count).to eq(2)
    expect(@bal_rec.balance).to eq(1000)
    expect(@scene.balance_records.last.accounts.where(acct_name: "CAR").last.balance).to eq(-5500 - 5500*0.06/365)
  end

  it "#run should vest when appropriate" do
    @scene.balance_records << @bal_rec
    @scene.run(Date.new(2016,2,3), Date.new(2016,2,20))
    br = @scene.balance_records.select { |bal_rec| bal_rec.date == Date.new(2016, 2, 13) }
####
#      puts @scene.balance_records.count
#      @scene.balance_records.all.each do |br_|
#        puts br_
#        br_.accounts.all.each do |acct|
#          puts "\tAcct: #{acct.acct_name}, Bal: #{acct.balance}"
#        end
#      end
####

    expect(br.last.balance).to eq(0)
  end
  #it "#run should not vest when not appropriate"

  it "#create_balance_record_list should not create a balance record with bad dates" do
    sc = create(:scenario)
    sc.create_balance_record_list(Date.today, Date.today - 1)
    expect(sc.balance_records.count).to eq(0)
  end

  it "#create_balance_record_list should delete any preexisting \
      balance_records within the given range" do
    @scene.balance_records << create(:balance_record, scenario_id: @scene.id, date: Date.today)
    @scene.balance_records << create(:balance_record, scenario_id: @scene.id,date: Date.today - 1)
    @scene.balance_records << create(:balance_record, scenario_id: @scene.id,date: Date.today + 1)
    @scene.save
#    puts "***#{@scene.balance_records.count}***"
    @scene.create_balance_record_list(Date.today, Date.today + 1)
    expect(@scene.balance_records.count).to eq(3)
  end

  it "#create_balance_record_list creates the right number of balance records" do
    sc = create(:scenario)
    sc.create_balance_record_list(Date.today, Date.today + 5)
    expect(sc.balance_records.count).to eq(6)
  end

  it "#create_balance_records_list give the balance records the correct dates" do
    sc = create(:scenario)
    sc.create_balance_record_list(Date.today, Date.today + 5)
    sc.balance_records.each_with_index { |br, i| expect(br.date).to eq(Date.today + i) }
  end
end
