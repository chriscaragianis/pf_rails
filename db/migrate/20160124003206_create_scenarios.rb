class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.float :balance
      t.string :name
      t.date :today
      t.float :vest_level
      t.float :min_balance
      t.string :vest_targets

      t.timestamps null: false
    end
  end
end
