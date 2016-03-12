require 'json'

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
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    br = BalanceRecord.new(date: start_date, balance: params[:balance].to_d)
    br.accounts = Account.all
    @sc.balance_records = [br]
    puts br
    @sc.run(start_date, end_date)
    @sc.save
    points = []
    @sc.balance_records.each_with_index do |rec, index|
      points << [index, rec.balance]
    end
    File.write('public/point_file.json', JSON.generate(points))
  end

  private
    def scenario_params
      params.require(:scenario).permit(
        :name,
        :vest_level
      )
    end
end

