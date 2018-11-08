class PrefabStoreSerializer < ActiveModel::Serializer
  attribute :id, key: :x
  attribute :name, key: :n
end