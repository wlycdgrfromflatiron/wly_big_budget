class PrefabItem < ApplicationRecord
    has_many :cart_items
    has_many :carts, through: :cart_items
    has_many :prefab_item_tags
    has_many :tags, through: :prefab_item_tags
end