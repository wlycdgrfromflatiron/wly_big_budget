class StoreLocation < ApplicationRecord
    has_many :carts
    belongs_to :store
end