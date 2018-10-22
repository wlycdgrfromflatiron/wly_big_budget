class TagSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name, key: :n
  attribute :carts, key: :c
  attribute :total_spent, key: :t
  has_many :prefab_stores, key: :s
  has_many :prefab_items, key: :i
end
