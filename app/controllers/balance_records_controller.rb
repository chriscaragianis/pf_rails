class BalanceRecordsController < ApplicationController
  include ApplicationHelper
  def new
    if (Scenario.count > 0) then
      @scene = Scenario.last
    else
      flash.alert = "You must define a Scenario"
      redirect_to '/scenarios/new'
    end
  end

  def create
    br = BalanceRecord.new(balance_record_params)
    br.scenario_id = Scenario.last.id
    br.save
  end

  private
    def balance_record_params 
      params.require(:balance_record).permit(
        :balance,
        :date
      )
    end
end
