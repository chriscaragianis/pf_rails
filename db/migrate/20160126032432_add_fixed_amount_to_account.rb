class AddFixedAmountToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :fixed_amount, :float
  end
end
