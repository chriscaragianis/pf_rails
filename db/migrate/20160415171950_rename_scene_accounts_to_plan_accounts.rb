class RenameSceneAccountsToPlanAccounts < ActiveRecord::Migration
  def change
    rename_table :scene_accounts, :plan_accounts
  end
end
