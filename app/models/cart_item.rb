class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :prefab_item
  has_many :tags
end
