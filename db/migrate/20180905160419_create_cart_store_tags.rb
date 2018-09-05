class CreateCartStoreTags < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_store_tags do |t|
      t.belongs_to :cart_store
      t.belongs_to :tag
    end
  end
end
