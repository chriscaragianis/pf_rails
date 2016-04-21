class RenameScenariosToPlans < ActiveRecord::Migration
  def change
    rename_table :scenarios, :plans
  end
end
