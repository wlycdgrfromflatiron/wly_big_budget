class PrefabStore < ApplicationRecord
    belongs_to :user
    has_many :cart_stores
    has_many :carts, through: :cart_stores
    has_many :prefab_store_tags
    has_many :tags, through: :prefab_store_tags

    def name_and_tag_names
      "#{name} (#{self.tag_names.join(', ')})"
    end

    def tag_names
        tags ? tags.map {|tag| tag.name } : []
    end

    def total_spent
        carts.reduce(0) {|dollars, cart| dollars += cart.total }
    end
end
