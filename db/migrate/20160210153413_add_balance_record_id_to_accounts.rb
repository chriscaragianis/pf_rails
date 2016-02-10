class AddBalanceRecordIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :balance_record_id, :integer
  end
end
