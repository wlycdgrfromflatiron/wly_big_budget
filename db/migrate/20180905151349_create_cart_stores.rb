class CreateCartStores < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_stores do |t|
      t.belongs_to :cart, index: true
      t.belongs_to :prefab_store, index: true
      t.string :note
    end
  end
end