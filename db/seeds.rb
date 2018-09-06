# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def make_user_hash(name)
  {
    name: name,
    email: name + "@gmail.com",
    password: name,
    email_confirmed: true,
    confirm_token: nil
  }
end

User.create([
  make_user_hash('ilya'), # id 1
  make_user_hash('wlycdgr'), #id 2
  make_user_hash('willa'), #id 3
])
