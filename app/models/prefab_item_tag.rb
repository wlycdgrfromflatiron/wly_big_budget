class PrefabItemTag < ApplicationRecord
    belongs_to :prefab_item
    belongs_to :tag
end