class Cart < ApplicationRecord
  belongs_to :user
  has_many :items
  has_many :prefab_items, through: :items
  has_one :store
  has_one :prefab_store, through: :store

  def total
    items.reduce(0) { |total, item| total += item.price }
  end
end
