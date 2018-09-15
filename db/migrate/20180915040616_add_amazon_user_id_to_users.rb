class AddAmazonUserIdToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :amazon_user_id, :integer
  end

  def down
    remove_column :users, :amazon_user_id
  end
end
