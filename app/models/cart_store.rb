class CartStore < ApplicationRecord
  belongs_to :cart
  belongs_to :prefab_store
  has_many :tags
end
