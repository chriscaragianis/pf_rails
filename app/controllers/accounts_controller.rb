class AccountsController < ApplicationController
  include ApplicationHelper
  def index
    @accounts = Account.all
  end

  def new
  end

  def show
  end

  def create
    acct = Account.new(account_params)
    acct.user_id = current_user.id
    acct.save
    render "accounts/new"
  end

  private
    def account_params
      params.require(:account).permit(
        :acct_name,
        :rate,
        :weekly,
        :balance,
        :day,
        :min_floor,
        :min_rate,
        :fixed_amount,
        :carry_balance,
        :week_period,
        :week_offset,
        :vest_priority
      )
    end
end
