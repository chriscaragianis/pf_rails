class ScenariosController < ApplicationController
  include ApplicationHelper
  def new
  end

  def create
    scene = Scenario.new(scenario_params)
    scene.save
  end

  def run_scenario
    @sc = Scenario.last
    @sc.balance_records.delete_all
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    br = BalanceRecord.new(balance: params[:balance], date: start_date)
    br.scenario_id = @sc.id
    br.save
    @sc.run(start_date + 1, end_date)
    @sc.save
  end

  private
    def scenario_params
      params.require(:scenario).permit(
        :name,
        :vest_level
      )
    end
end

