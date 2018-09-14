class Tag < ApplicationRecord
  has_many :user_tags
  has_many :users, through: :user_tags
  has_many :cart_store_tags
  has_many :cart_stores, through: :cart_store_tags
  has_many :cart_item_tags
  has_many :cart_items, through: :cart_item_tags
  has_many :prefab_item_tags
  has_many :prefab_items, through: :prefab_item_tags
  has_many :prefab_store_tags
  has_many :prefab_stores, through: :prefab_store_tags

  def cart_items_directly_or_through_prefab_items
    cart_items_through_prefab_items = prefab_items.collect do |prefab_item|
      prefab_item.cart_items
    end
    cart_items_through_prefab_items.flatten!

    direct_cart_items = cart_items 

    direct_cart_items.concat(cart_items_through_prefab_items).uniq!
  end
end
