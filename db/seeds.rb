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

def create_prefabs prefab_class_name, user_name, prefab_instance_names
  user = User.find_by(name: user_name)
  prefab_class = prefab_class_name.camelize.constantize

  prefab_instance_names.each do |pin|
    prefab_class.create({
      name: pin,
      user: user
    })
  end
end

def create_tag(name, users_and_prefabs)
  tag = Tag.create({name: name})

  users_and_prefabs.each do |user_and_prefabs|
    user = User.find_by(name: user_and_prefabs[0])

    tag.users << user

    user_and_prefabs[1].each do |prefab_store_name|
      tag.prefab_stores << user.prefab_stores.find_by(name: prefab_store_name)
    end

    user_and_prefabs[2].each do |prefab_item_name|
      tag.prefab_items << user.prefab_items.find_by(name: prefab_item_name)
    end
  end

  tag.save
end

User.create([
  make_user_hash('ilya'), # id 1
  make_user_hash('wlycdgr'), #id 2
  make_user_hash('willa'), #id 3
])

create_prefabs(
  'prefab_store',
  'ilya',
  [
    'Best Buy Union Square',
    'The Strand',
    'Amazon'
  ]
)

create_prefabs(
  'prefab_item',
  'ilya',
  [
    'Bodega iced coffee',
    'Egg & cheese on a roll with pickles and jalapenos',
    'Seltzer',
    'Programming Book',
    'Anthology Film Archives ticket'
  ]
)

create_tag('NYC', [
  ['ilya', ['Best Buy Union Square', 'The Strand'], []]
])

create_tag('favorite', [
  ['ilya', ['The Strand', 'Amazon'], []]
])

create_tag('online', [
  ['ilya', ['Amazon'], []]
])

create_tag('bookstore', [
  ['ilya', ['The Strand'], []]
])

create_tag('independent', [
  ['ilya', ['The Strand'], []]
])

create_tag('24hr', [
  ['ilya', ['Best Buy Union Square'], []]
])
