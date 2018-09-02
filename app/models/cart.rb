class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :items, through: :cart_items
  has_one :cart_store
  has_one :store, through: :cart_store

  def total
    total = 0
    items.each do |item|
      total += item.price
    end
    total
  end
end
