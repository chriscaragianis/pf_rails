class AddScenarioIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :scenario_id, :integer
  end
end
