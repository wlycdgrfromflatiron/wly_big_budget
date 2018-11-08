class PrefabItemTagSerializer < ActiveModel::Serializer
    attribute :id, key: :x
    attribute :prefab_item_id, key: :p
    attribute :tag_id, key: :t
end