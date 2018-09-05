class CartStore < ApplicationRecord
  belongs_to :cart
  belongs_to :prefab_store
  has_many :cart_store_tags
  has_many :tags, through: :cart_store_tags
end
