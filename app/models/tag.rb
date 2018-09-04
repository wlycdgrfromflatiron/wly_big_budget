class Tag < ApplicationRecord
  has_many :stores
  has_many :items
  has_many :prefab_items
  has_many :prefab_stores
end
