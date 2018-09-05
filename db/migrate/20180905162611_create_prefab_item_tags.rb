class CreatePrefabItemTags < ActiveRecord::Migration[5.2]
  def change
    create_table :prefab_item_tags do |t|
      t.belongs_to :prefab_item, index: true
      t.belongs_to :tag, index: true
    end
  end
end
