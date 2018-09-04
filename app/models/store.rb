class Store < ApplicationRecord
  has_many :store_locations
  has_many :carts, through: store_locations
  has_many :tags
end
