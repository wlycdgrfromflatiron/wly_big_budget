class AddPriceAndNoteToCartItems < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :price, :integer
    add_column :cart_items, :note, :string
  end
end
