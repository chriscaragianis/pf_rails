require 'json'
require 'date_conversion'


class PlansController < ApplicationController
  include ApplicationHelper
  respond_to :json, :html
  
  def index
  end

  def new
    if !logged_in? then
      flash[:error] = "You must be logged in!"
      redirect_to "/login"
    end
  end

  def show
    @sc = Plan.find(params[:id])
    if @sc.user_id != current_user.id then
      flash[:danger] = "You are not permitted to view this plan."
      redirect_to "/dashboard"
    end
  end

  def destroy
    Plan.find(params[:id]).destroy
    redirect_to "/dashboard"
  end

  def create
    pl = Plan.new(name: plan_params[:name],
                         vest_level: plan_params[:vest_level])
    pl.user_id = current_user.id
    if pl.save then
      acc_list = plan_params
      acc_list.delete(:name)
      acc_list.delete(:vest_level)
      acc_list.each do |name, id|
        if id == '1' then 
          PlanAccount.create(plan_id: pl.id,
                             account_id: Account.find_by(acct_name: name).id)
        end
      end
      flash[:success] = "Success!"
      redirect_to "/plans/index"
    else
      flash[:error] = "An error occurred, please try again"
      redirect_to "/plans/new"
    end
  end

  def run_plan
    @sc = Plan.find_by(id: params[:plan_choice])
    @sc.balance_records = []
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    br = BalanceRecord.new(date: start_date, balance: params[:balance].to_d)
    br.accounts = @sc.accounts.to_a
    @sc.balance_records = [br]
    @sc.run(start_date, end_date, [])
    @sc.save
    data = Hash.new
    data["accounts"] = Hash.new
    cb_accts = @sc.balance_records[0].accounts.select {|acct| acct.carry_balance == true}
    cb_accts.each do |acct|
      data["accounts"][acct.acct_name] = Hash.new
      data["accounts"][acct.acct_name]["balances"] = []
      @sc.balance_records.each do |balrec|
        data["accounts"][acct.acct_name]["balances"] << [date_conv(balrec.date), balrec.accounts[@sc.accounts.to_a.index(acct)].balance.to_f]
      end
    end
    data["accounts"]["Balance"] = Hash.new
    data["accounts"]["Balance"]["balances"] = []
    @sc.balance_records.each do |rec|
      data["accounts"]["Balance"]["balances"] << [date_conv(rec.date), rec.balance.to_f]
    end
    respond_with data  
  end
  
  private
    def plan_params
      params.require(:plan).permit(
        :name,
        :vest_level,
        Account.select {|a| a.user_id == current_user.id}.map {|a| a.acct_name}
      )
    end
end

