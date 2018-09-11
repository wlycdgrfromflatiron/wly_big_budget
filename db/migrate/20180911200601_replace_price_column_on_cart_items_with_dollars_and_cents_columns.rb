class ReplacePriceColumnOnCartItemsWithDollarsAndCentsColumns < ActiveRecord::Migration[5.2]
  def up
    remove_column :cart_items, :price, :integer
    add_column :cart_items, :dollars, :integer, default: 0
    add_column :cart_items, :cents, :integer, default: 0
  end

  def down
    add_column :cart_items, :price, :integer
    remove_column :cart_items, :dollars, :integer, default: 0
    remove_column :cart_items, :cents, :integer, default: 0
  end
end
