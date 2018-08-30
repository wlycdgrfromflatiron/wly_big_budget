class Store < ApplicationRecord
  has_many :carts
  # has_many :users, through: :carts # true, but is it relevant?
end
