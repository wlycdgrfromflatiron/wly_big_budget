class PrefabStoreTagSerializer < ActiveModel::Serializer
    attribute :id, key: :x
    attribute :prefab_store_id, key: :p
    attribute :tag_id, key: :t
end