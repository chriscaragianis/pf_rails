class AddCarryBalanceToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :carry_balance, :boolean
  end
end
