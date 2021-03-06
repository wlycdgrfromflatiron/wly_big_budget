class CartStore < ApplicationRecord
  belongs_to :cart
  belongs_to :prefab_store, optional: true
  has_many :cart_store_tags
  has_many :tags, through: :cart_store_tags

  validates :note, presence: true, unless: :prefab_store
end
