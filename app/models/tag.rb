class Tag < ApplicationRecord
  has_many :stores
  has_many :items
  has_many :cart_items
end
