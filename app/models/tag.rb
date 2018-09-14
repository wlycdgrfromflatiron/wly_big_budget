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



  # TODO generalize these two getters
  def cart_items_directly_or_through_prefab_items
    cart_items_through_prefab_items = prefab_items.collect do |prefab_item|
      prefab_item.cart_items
    end
    cart_items_through_prefab_items.flatten!

    (cart_items + cart_items_through_prefab_items).uniq!
  end

  def cart_stores_directly_or_through_prefab_stores
    cart_stores_through_prefab_stores = prefab_stores.collect do |prefab_store|
      prefab_store.cart_stores
    end
    cart_stores_through_prefab_stores.flatten!

    (cart_stores + cart_stores_through_prefab_stores).uniq!
  end
  
  def total_spent
    cart_items_directly_or_through_prefab_items.reduce(0) do |dollars, cart_item| 
      dollars += cart_item.dollars
    end
  end
end
