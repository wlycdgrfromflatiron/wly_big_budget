class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :items, through: :cart_items
  has_one :store_location
  has_one :store, through: :store_location

  def total
    total = 0
    # refactor to use Array#reduce, if available
    cart_items.each do |cart_item|
      total += cart_item.price
    end
    total
  end
end
