class Account < ActiveRecord::Base

  def to_s
    return "Name: #{self.acct_name}, Balance: #{self.balance}"
  end

end
