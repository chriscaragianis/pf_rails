class AddStartBalanceToScenarios < ActiveRecord::Migration
  def change
    add_column :scenarios, :start_balance, :float
  end
end
