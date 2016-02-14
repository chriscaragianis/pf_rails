require 'rails_helper'
require 'factory_girl_rails'

# Specs in this file have access to a helper object that includes
# the ScenarioHelper. For example:
#
# describe ScenarioHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ScenarioHelper, type: :helper do	
  before(:all) do
    @bal_rec = create(:balance_record)
    acct = create(:account,
      acct_name: "CREDIT ACCOUNT",
		  balance: -1000,
		  rate: 0.10*365,
		  carry_balance: true,
                  fixed_amount: 0,
		  min_rate: 0,
		  day: @bal_rec.date.day
		 )
    acct2 = create(:account,
      acct_name: "PAYCHECK",
      fixed_amount: -75,
      day: @bal_rec.date.day
    )
    @bal_rec.accounts = [acct2, acct];
    @bal_rec.save
  end

  it "#day_calc returns a hash of a valid balance record of the correct size" do
    new_bal = BalanceRecord.new(day_calc(@bal_rec))
    new_bal.save
    expect(new_bal).to be_valid
    expect(new_bal.accounts.count).to eq(@bal_rec.accounts.count)
  end

  it "#day_calc correctly changes the date" do
    expect(helper.day_calc(@bal_rec)[:date]).to eq(@bal_rec.date + 1)
  end

  it "#day_calc correctly compounds interest" do
    expect(helper.day_calc(@bal_rec)[:accounts].last.balance).to eq(-1100)
  end

  it "#day_calc correctly debits a bill" do
    @bal_rec.accounts.last.update(fixed_amount: 200, rate: 0)
    expect(helper.day_calc(@bal_rec)[:balance]).to eq(@bal_rec.balance - 125)
  end

  it "#day_calc correctly credits a bill" do
    @bal_rec.accounts.last.update(fixed_amount: 200)
    expect(helper.day_calc(@bal_rec)[:accounts].last.balance).to eq(@bal_rec.accounts.last.balance + 200)
  end

  it "#day_calc doesn't change the balance unless carry_balance" do
    expect(helper.day_calc(@bal_rec)[:accounts].first.balance).to eq(0)
  end

end
