class Tag < ApplicationRecord
  has_many :cart_stores
  has_many :cart_items
  has_many :prefab_items
  has_many :prefab_store_tags
  has_many :prefab_stores, through: :prefab_store_tags
end
