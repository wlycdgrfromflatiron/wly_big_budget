class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :prefab_items, through: :cart_items
  has_one :cart_store
  has_one :prefab_store, through: :cart_store
  accepts_nested_attributes_for :cart_items
  accepts_nested_attributes_for :cart_store

  def total
    cart_items.reduce(0) { |total, cart_item| total += cart_item.price }
  end
end
