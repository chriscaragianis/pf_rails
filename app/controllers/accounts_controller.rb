class AccountsController < ApplicationController
  include ApplicationHelper
  def index
    @accounts = Account.all
  end

  def destroy
    Account.find(params[:id]).destroy
    redirect_to "/dashboard"
  end

  def new
    if !logged_in? then
      flash[:error] = "You must be logged in!"
      redirect_to new_user_path
    end
  end

  def show
    @acct = Account.find(params[:id])
    if @acct.user_id != current_user.id then
      flash[:danger] = "You are not permitted to view this account."
      redirect_to "/dashboard"
    end
  end

  def create
    p = account_params
    done = p.delete("done_with_accounts")
    acct = Account.new(p)
    acct.user_id = current_user.id
    if acct.save then
      flash[:success] = "Success!"
      done == "1" ? redirect_to("/users/#{current_user.id}") : redirect_to("/accounts/new")
    else
      flash[:error] = "An error occurred, please try again"
      render "accounts/new"
    end
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
        :vest_priority,
        :done_with_accounts
      )
    end
end
