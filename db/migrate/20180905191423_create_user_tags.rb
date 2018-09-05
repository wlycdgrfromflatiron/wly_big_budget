class CreateUserTags < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tags do |t|
      t.belongs_to :user
      t.belongs_to :tag
    end
  end
end
