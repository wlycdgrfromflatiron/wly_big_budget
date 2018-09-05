class CreatePrefabStores < ActiveRecord::Migration[5.2]
  def change
    create_table :prefab_stores do |t|
      t.string :name
    end
  end
end