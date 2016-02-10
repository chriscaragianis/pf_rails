class AddScenarioIdToBalanceRecord < ActiveRecord::Migration
  def change
    add_column :balance_records, :scenario_id, :integer
  end
end
