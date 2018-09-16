class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :prefab_items, through: :cart_items
  has_one :cart_store, dependent: :destroy
  has_one :prefab_store, through: :cart_store
  accepts_nested_attributes_for :cart_items
  accepts_nested_attributes_for :cart_store

  validates :note, presence: true
  validates :date, presence: true
  validates :cart_store, presence: true
  validates :cart_items, presence: true

  def self.total
    Cart.all.reduce(0) { |total, cart| total += cart.total }
  end

  def total
    cart_items.reduce(0) { |total, cart_item| total += cart_item.price }
  end
end
