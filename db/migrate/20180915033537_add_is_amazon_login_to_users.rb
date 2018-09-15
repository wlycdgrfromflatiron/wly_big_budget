class AddIsAmazonLoginToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :is_amazon_login, :boolean, default: false
  end

  def down
    remove_column :users, :is_amazon_login
  end
end
