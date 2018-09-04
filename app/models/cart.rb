class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :prefab_items, through: :cart_items
  has_one :cart_store
  has_one :prefab_store, through: :cart_store

  def total
    items.reduce(0) { |total, item| total += item.price }
  end
end
