class PrefabStore < ApplicationRecord
    has_many :cart_stores
    has_many :carts, through: :cart_stores
    has_many :tags
end