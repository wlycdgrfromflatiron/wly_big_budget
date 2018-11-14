class CartItemTagSerializer < ActiveModel::Serializer
    attribute :id, key: :x
    attribute :cart_item_id, key: :c
    attribute :tag_id, key: :t
end