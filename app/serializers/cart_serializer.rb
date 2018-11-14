class CartSerializer < ActiveModel::Serializer
    attribute :id, key: :x
    attribute :date, key: :d
    attribute :note, key: :n
end