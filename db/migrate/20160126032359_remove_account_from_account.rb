class RemoveAccountFromAccount < ActiveRecord::Migration
  def change
    remove_column :accounts, :amount, :float
  end
end
