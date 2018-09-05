class CreateCartItemTags < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_item_tags do |t|
      t.belongs_to :cart_item, index: true
      t.belongs_to :tag, index: true
    end
  end
end
