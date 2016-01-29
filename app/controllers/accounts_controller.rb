class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end

  def new
  end

  def show
  end

  def create
    render "accounts/choice"
    acct = Account.new(account_params)
    acct.save
  end

  private
    def account_params
      params.require(:account).permit(:acct_name, :rate, :weekly, :balance, :day, :min_floor,
                                      :min_rate, :fixed_amount, :carry_balance)
    end
end
