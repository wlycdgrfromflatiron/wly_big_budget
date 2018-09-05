class AddBelongsToUserToPrefabItems < ActiveRecord::Migration[5.2]
  def change
    add_column :prefab_items, :user_id, :integer
  end
end
