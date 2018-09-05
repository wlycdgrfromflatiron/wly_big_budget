class PrefabStore < ApplicationRecord
    belongs_to :user
    has_many :cart_stores
    has_many :carts, through: :cart_stores
    has_many :prefab_store_tags
    has_many :tags, through: :prefab_store_tags
end
