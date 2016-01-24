class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.float :rate
      t.float :balance
      t.float :min_floor
      t.float :min_rate
      t.string :acct_name
      t.boolean :weekly
      t.integer :week_offset
      t.integer :week_period
      t.integer :day
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
