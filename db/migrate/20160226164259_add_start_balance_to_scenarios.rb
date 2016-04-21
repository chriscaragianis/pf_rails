class AddStartBalanceToScenarios< ActiveRecord::Migration
  def change
    add_column :scnearios, :start_balance, :float
  end
end
