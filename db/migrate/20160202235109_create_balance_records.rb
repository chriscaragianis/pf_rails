class CreateBalanceRecords < ActiveRecord::Migration
  def change
    create_table :balance_records do |t|
      t.date :date
      t.float :balance
      t.string :name

      t.timestamps null: false
    end
  end
end
