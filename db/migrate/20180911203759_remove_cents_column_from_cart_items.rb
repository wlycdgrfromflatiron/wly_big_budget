class RemoveCentsColumnFromCartItems < ActiveRecord::Migration[5.2]
  def up
    remove_column :cart_items, :cents, :integer, default: 0
  end 

  def down
    add_column :cart_items, :cents, :integer, default: 0
  end
end
