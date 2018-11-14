class CartStoreSerializer < ActiveModel::Serializer
    attribute :id, key: :x
    attribute :cart_id, key: :c
    attribute :prefab_store_id, key: :p
    attribute :note, key: :n
end