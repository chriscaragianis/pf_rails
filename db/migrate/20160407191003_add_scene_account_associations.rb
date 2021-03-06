class AddSceneAccountAssociations < ActiveRecord::Migration
  def change
    change_table :scene_accounts do |t|
      t.belongs_to :account, index: true
      t.belongs_to :scenario, index: true
    end
  end
end
