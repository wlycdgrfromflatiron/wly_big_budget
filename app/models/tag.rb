class Tag < ApplicationRecord
  has_many :cart_store_tags
  has_many :cart_stores, through: :cart_store_tags
  has_many :cart_item_tags
  has_many :cart_items, through: :cart_item_tags
  has_many :prefab_item_tags
  has_many :prefab_items, through: :prefab_item_tags
  has_many :prefab_store_tags
  has_many :prefab_stores, through: :prefab_store_tags
end
