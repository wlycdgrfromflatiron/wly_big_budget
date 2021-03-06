class PrefabItem < ApplicationRecord
    belongs_to :user
    has_many :cart_items
    has_many :carts, through: :cart_items
    has_many :prefab_item_tags
    has_many :tags, through: :prefab_item_tags

    validates :name, presence: true
    validates_uniqueness_of :name, scope: :user

    def name_and_tag_names
        "#{name} (#{self.tag_names.join(', ')})"
      end
  
    def tag_names
        tags ? tags.map {|tag| tag.name } : []
    end

    def total_spent
        cart_items.reduce(0) {|total, cart_item| total += cart_item.price }
    end
end
