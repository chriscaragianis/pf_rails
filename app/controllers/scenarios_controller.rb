require 'json'

class ScenariosController < ApplicationController
  include ApplicationHelper
  def new
    if !logged_in? then
      flash[:error] = "You must be logged in!"
      redirect_to "/login"
    end
  end

  def create
    scene = Scenario.new(name: scenario_params[:name],
                         vest_level: scenario_params[:vest_level])
    scene.user_id = current_user.id
    if scene.save then
      acc_list = scenario_params
      acc_list.delete(:name)
      acc_list.delete(:vest_level)
      acc_list.each do |name, id|
        if id == '1' then 
          SceneAccount.create(scenario_id: scene.id,
                              account_id: Account.find_by(acct_name: name).id)
        end
      end
      flash[:success] = "Success!"
      redirect_to "/users/#{current_user.id}"
    else
      flash[:error] = "An error occurred, please try again"
      redirect_to "/scenarios/new"
    end
  end

  def run_scenario
    @sc = Scenario.find_by(id: params[:scenario_choice])
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    br = BalanceRecord.new(date: start_date, balance: params[:balance].to_d)
    br.accounts = @sc.accounts.to_a
    @sc.balance_records = [br]
    @sc.run(start_date, end_date)
    @sc.save
    cb_accts = @sc.balance_records[0].accounts.select {|acct| acct.carry_balance == true}
    @bal_points = []
    @acct_points = []
    cb_accts.size.times { @acct_points << [] }
    @sc.balance_records.each_with_index do |rec, index|
      @bal_points << [index, rec.balance.to_f]
      rec.accounts.select {|a| a.carry_balance }.each_with_index do |acct, index_2|
        @acct_points[index_2] << [index, acct.balance.to_f]
      end
    end
  end

  private
    def scenario_params
      params.require(:scenario).permit(
        :name,
        :vest_level,
        *Account.select {|a| a.user_id == current_user.id}.map {|a| a.acct_name}
      )
    end
end

