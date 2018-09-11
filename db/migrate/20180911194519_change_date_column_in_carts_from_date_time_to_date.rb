class ChangeDateColumnInCartsFromDateTimeToDate < ActiveRecord::Migration[5.2]
  def change
    change_column :carts, :date, :date
  end
end
