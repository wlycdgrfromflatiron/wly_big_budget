class CartItemTag < ApplicationRecord
    belongs_to :cart_item
    belongs_to :tag
end