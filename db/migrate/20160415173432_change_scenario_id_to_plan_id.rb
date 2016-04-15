class ChangeScenarioIdToPlanId < ActiveRecord::Migration
  def change
    rename_column :plan_accounts, :scenario_id, :plan_id
  end
end
