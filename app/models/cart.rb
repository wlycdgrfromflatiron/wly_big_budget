class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :store
  has_many :items

  def total
    total = 0
    items.each do |item|
      total += item.price
    end
    total
  end
end
