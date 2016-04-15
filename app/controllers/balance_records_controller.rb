class BalanceRecordsController < ApplicationController
  include ApplicationHelper
  def new
    if current_user.nil? then
      flash[:error] = "You must be logged in!"
      redirect_to "/login"
      return
    end
    if (Plan.count > 0) then
      sc = Plan.all.select{|s| s.user_id == current_user[:id]}
      @plan_options_list = []
      sc.each do |s|
        @plan_options_list << [s.name, s.id]
      end
    else
      flash.alert = "You must define a Plan"
      redirect_to '/plans/new'
    end
  end

  def create
    br = BalanceRecord.new(balance_record_params)
    br.plan_id = Plan.last.id
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
