class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :prefab_item, optional: true
  has_many :cart_item_tags
  has_many :tags, through: :cart_item_tags

  validates :note, presence: true, unless: :prefab_item

  # from when I also had cents - leave for now as it is an intuitive alias
  def price
    dollars
  end

  def description
    if note.empty?
      if prefab_item
        prefab_item.name
      else
        "[~a mysterious item with no note or prefab~]"
      end
    else
      note
    end
  end
end
