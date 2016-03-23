require 'json'

class ScenariosController < ApplicationController
  include ApplicationHelper
  def new
  end

  def create
    scene = Scenario.new(scenario_params)
    scene.user_id = current_user.id
    scene.save
  end

  def run_scenario
    @sc = Scenario.last
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    br = BalanceRecord.new(date: start_date, balance: params[:balance].to_d)
    br.accounts = Account.all
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
        :vest_level
      )
    end
end

