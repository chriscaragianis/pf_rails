module ScenariosHelper
  def day_calc bal_rec
    accounts = []
    balance = bal_rec.balance
    bal_rec.accounts.all.each do |val|
      val.compound
      if (val.carry_balance) then
        val.balance += val.bill(bal_rec.date)
      end
      balance -= val.bill(bal_rec.date)
      accounts << val 
      val.save
    end
    Hash[date: bal_rec.date + 1, balance: balance, accounts: accounts]
  end
end
