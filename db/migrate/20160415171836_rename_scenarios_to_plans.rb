class RenameScenariosToPlans < ActiveRecord::Migration
  def change
    rename_table :plans, :plans
  end
end
