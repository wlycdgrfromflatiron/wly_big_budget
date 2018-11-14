class UserSerializer < ActiveModel::Serializer
    has_many :tags
    has_many :prefab_items
    has_many :prefab_item_tags
    has_many :prefab_stores
    has_many :prefab_store_tags
    has_many :carts
    has_many :cart_items
    has_many :cart_item_tags
    has_many :cart_stores
    has_many :cart_store_tags
end

  
  