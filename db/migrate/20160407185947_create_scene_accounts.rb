class CreateSceneAccounts < ActiveRecord::Migration
  def change
    create_table :scene_accounts do |t|

      t.timestamps null: false
    end
  end
end
