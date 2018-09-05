class CreatePrefabStoreTags < ActiveRecord::Migration[5.2]
  def change
    create_table :prefab_store_tags do |t|
      t.belongs_to :prefab_store, index: true
      t.belongs_to :tag, index: true
    end
  end
end
