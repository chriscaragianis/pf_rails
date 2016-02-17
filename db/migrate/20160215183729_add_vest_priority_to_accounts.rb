class AddVestPriorityToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :vest_priority, :integer
  end
end
