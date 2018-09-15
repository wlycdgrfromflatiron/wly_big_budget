class ChangeAmazonUserIdInUsersFromIntegerToString < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :amazon_user_id, :string
  end

  def down
    change_column :users, :amazon_user_id, :integer
  end
end
