class CartItemSerializer < ActiveModel::Serializer
    attribute :id, key: :x
    attribute :cart_id, key: :c
    attribute :prefab_item_id, key: :p
    attribute :note, key: :n
    attribute :dollars, key: :d
end