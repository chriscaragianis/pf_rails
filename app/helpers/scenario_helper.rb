module ScenarioHelper
  def day_calc bal_rec
    accounts = []
    balance = bal_rec.balance
    bal_rec.accounts.each do |val|
      new_account = val.acct_copy
      new_account.compound
      new_account.balance += new_account.bill(bal_rec.date)
      balance -= new_account.bill(bal_rec.date)
      accounts << new_account
    end
    BalanceRecord.new(date: bal_rec.date + 1, balance: balance, accounts: accounts)
  end
end
