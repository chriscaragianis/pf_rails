require 'Scenario'
require 'date'
class ScenarioController < ApplicationController

  def enter
  end

  def run
    @scene = Scenario.new(name: params[:name], vest_level: params[:vest_level].to_i,
                          balances: [BalanceRecord.new(balance: params[:start_balance].to_i,
                                                      date: Date.strptime(params[:start_day], '%Y-%m-%d'),
                                                      accounts: Account.all)])
    @scene.run(Date.strptime(params[:start_day], '%Y-%m-%d'), Date.strptime(params[:finish_day], '%Y-%m-%d'))
  end
end
