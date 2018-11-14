class User < ApplicationRecord
  has_many :carts
  has_many :cart_items, through: :carts
  has_many :cart_item_tags, through: :cart_items
  has_many :prefab_stores #new
  has_many :prefab_store_tags, through: :prefab_stores
  has_many :prefab_items #new
  has_many :prefab_item_tags, through: :prefab_items
  has_many :user_tags #new
  has_many :tags, through: :user_tags #new

  has_secure_password
  before_create :confirmation_token

  def total
    carts.reduce(0) { |total, cart| total += cart.total }
  end

  def mark_email_confirmed
    self.email_confirmed = true
    self.confirm_token = nil
    self.save!
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
