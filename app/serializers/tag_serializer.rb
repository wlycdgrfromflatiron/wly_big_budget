class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :carts, :total_spent
  has_many :prefab_stores
  has_many :prefab_items
  # has_many :prefab_item_tags
  # has_many :prefab_items, through: :prefab_item_tags
end
