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

def create_cart username:, date:, note:, store:, items:
  cart = Cart.new
  
  cart.user = User.find_by(name: username)
  cart.date = date
  cart.note = note

  cart.cart_store = CartStore.new(note: store[:note])
  if (pfs = store[:prefab_store_name])
    cart.cart_store.prefab_store = PrefabStore.find_by(name: pfs)
  end
  if (tag_names = store[:tag_names])
    tag_names.each do |tag_name|
      cart.cart_store.tags << Tag.find_by(name: tag_name)
    end
  end

  items.each do |item|
    new_item = CartItem.new
    new_item.cart = cart
    if item[:note]
      new_item.note = item[:note]
    end
    if item[:prefab_item_name]
      new_item.prefab_item = PrefabItem.find_by(name: item[:prefab_item_name])
    end
    if item[:tag_names]
      item[:tag_names].each do |tag_name|
        new_item.tags << Tag.find_by(name: tag_name)
      end
    end
    new_item.dollars = item[:dollars]

    cart.cart_items << new_item
  end
    
  cart.save 
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
    'Amazon',
    'Home bodega'
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
    'Anthology Film Archives ticket',
    'Coffeeshop coffee'
  ]
)

create_tag('ticket', [
  ['ilya', [], ['Anthology Film Archives ticket']]
])

create_tag('movie', [
  ['ilya', [], ['Anthology Film Archives ticket']]
])

create_tag('togo', [
  ['ilya', [], ['Bodega iced coffee']]
])

create_tag('bodega', [
  ['ilya', ['Home bodega'], ['Bodega iced coffee', 'Egg & cheese on a roll with pickles and jalapenos']]
])

create_tag('coffee', [
  ['ilya', [], ['Bodega iced coffee', 'Coffeeshop coffee']]
])

create_tag('beverage', [
  ['ilya', [], ['Bodega iced coffee', 'Seltzer', 'Coffeeshop coffee']]
])

create_tag('NYC', [
  ['ilya', ['Best Buy Union Square', 'The Strand'], ['Anthology Film Archives ticket']]
])

create_tag('favorite', [
  ['ilya', ['The Strand', 'Amazon', 'Home bodega'], ['Egg & cheese on a roll with pickles and jalapenos']]
])

create_tag('online', [
  ['ilya', ['Amazon'], []]
])

create_tag('bookstore', [
  ['ilya', ['The Strand'], []]
])

create_tag('independent', [
  ['ilya', ['The Strand'], ['Anthology Film Archives ticket']]
])

create_tag('24hr', [
  ['ilya', ['Best Buy Union Square', 'Home bodega'], []]
])

create_tag('game', [
  ['ilya', [], []]
])

create_tag('entertainment', [
  ['ilya', [], ['Anthology Film Archives ticket']]
])
  

create_cart(
  username: 'ilya',
  date: Date.parse('August 12 2018'),
  note: 'Bodega run',
  store: {
    prefab_store_name: 'Home bodega',
    note: 'Real Madrid are terrible cheaters',
    tag_names: ['NYC']
  },
  items: [
    {
      note: "So tasty and cheap",
      prefab_item_name: 'Egg & cheese on a roll with pickles and jalapenos',
      dollars: 2
    },
    {
      note: "Hot, milk, no sugar",
      dollars: 1
    }
  ]
)

create_cart(
  username: 'ilya',
  date: Date.parse('September 4 2018'),
  note: 'A lazy afternoon at Target',
  store: {
    note: 'This is the Atlantic Center one',
    tag_names: ['NYC']
  },
  items: [
    {
      note: "4x 1L bottle Market Pantry brand",
      prefab_item_name: 'Seltzer',
      dollars: 3,
      tag_names: ['favorite']
    },
    {
      note: "An award-winning board game I will never play",
      dollars: 15,
      tag_names: ['game', 'entertainment']
    },
    {
      note: "Those Ritz cracker shits, Sour Cream & Onion",
      dollars: 4
    }
  ]
)