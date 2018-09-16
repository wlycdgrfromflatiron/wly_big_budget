class Tag < ApplicationRecord
  has_many :user_tags
  has_many :users, through: :user_tags
  has_many :cart_store_tags
  has_many :cart_stores, through: :cart_store_tags
  has_many :cart_item_tags
  has_many :cart_items, through: :cart_item_tags
  has_many :prefab_item_tags
  has_many :prefab_items, through: :prefab_item_tags
  has_many :prefab_store_tags
  has_many :prefab_stores, through: :prefab_store_tags

  validates :name, presence: true

  def self.ten_most_popular
    (Tag.all.sort {|tag1, tag2| tag2.users.count - tag1.users.count }).slice(0, 10)
  end

  def all_cart_items
    if !@all_cart_items_memoized
      cart_items_through_prefab_items = prefab_items.collect do |prefab_item|
        prefab_item.cart_items
      end
      cart_items_through_prefab_items.flatten!

      @all_cart_items_memoized = (cart_items + cart_items_through_prefab_items).uniq
    end

    @all_cart_items_memoized
  end

  def carts
    if !@all_carts_memoized
      # all the carts of the cart items
      # + all the carts of the cart stores
      # uniq! the fuq out of that bitch
      cart_item_carts = all_cart_items.map do |cart_item|
        cart_item.cart
      end

      cart_store_carts = cart_stores.map do |cart_store|
        cart_store.cart
      end

      @all_carts_memoized = (cart_item_carts + cart_store_carts).uniq
    end

    @all_carts_memoized
  end

  
  def total_spent
    all_cart_items.reduce(0) do |dollars, cart_item| 
      dollars += cart_item.dollars
    end
  end
end
