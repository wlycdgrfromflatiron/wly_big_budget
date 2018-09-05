class CreatePrefabItems < ActiveRecord::Migration[5.2]
  def change
    create_table :prefab_items do |t|
      t.string :name
    end
  end
end
