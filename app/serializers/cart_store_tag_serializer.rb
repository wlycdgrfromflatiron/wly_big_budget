class CartStoreTagSerializer < ActiveModel::Serializer
    attribute :id, key: :x
    attribute :cart_store_id, key: :c
    attribute :tag_id, key: :t
end