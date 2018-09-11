class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :prefab_item, optional: true
  has_many :cart_item_tags
  has_many :tags, through: :cart_item_tags
end
