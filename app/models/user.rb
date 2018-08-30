class User < ApplicationRecord
  has_many :carts
  has_many :stores, through: :carts
  
  has_secure_password

  before_create :confirmation_token

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
