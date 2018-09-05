class AddBelongsToUserToPrefabStores < ActiveRecord::Migration[5.2]
  def change
    add_column :prefab_stores, :user_id, :integer
  end
end
