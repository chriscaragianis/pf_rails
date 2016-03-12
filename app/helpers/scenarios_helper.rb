module ScenariosHelper
  def day_calc bal_rec
    balance = bal_rec.balance
    br = BalanceRecord.new(date: bal_rec.date + 1, balance: balance)
    br.accounts = bal_rec.accounts.map { |acct| acct.acct_copy }
    br.accounts.each do |val|
      val.compound
      if (val.carry_balance) then
        val.balance += val.bill(bal_rec.date)
      end
      br.balance -= val.bill(bal_rec.date)
    end
    br
  end
end
