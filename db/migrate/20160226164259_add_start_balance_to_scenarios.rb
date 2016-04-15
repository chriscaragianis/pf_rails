class AddStartBalanceToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :start_balance, :float
  end
end
