module AccountSpecHelper
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
end
