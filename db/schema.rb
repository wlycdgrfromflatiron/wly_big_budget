# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_09_05_162611) do

  create_table "cart_item_tags", force: :cascade do |t|
    t.integer "cart_item_id"
    t.integer "tag_id"
    t.index ["cart_item_id"], name: "index_cart_item_tags_on_cart_item_id"
    t.index ["tag_id"], name: "index_cart_item_tags_on_tag_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "cart_id"
    t.integer "prefab_item_id"
    t.integer "price"
    t.string "note"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["prefab_item_id"], name: "index_cart_items_on_prefab_item_id"
  end

  create_table "cart_store_tags", force: :cascade do |t|
    t.integer "cart_store_id"
    t.integer "tag_id"
    t.index ["cart_store_id"], name: "index_cart_store_tags_on_cart_store_id"
    t.index ["tag_id"], name: "index_cart_store_tags_on_tag_id"
  end

  create_table "cart_stores", force: :cascade do |t|
    t.integer "cart_id"
    t.integer "prefab_store_id"
    t.string "note"
    t.index ["cart_id"], name: "index_cart_stores_on_cart_id"
    t.index ["prefab_store_id"], name: "index_cart_stores_on_prefab_store_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "date"
    t.text "note"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "prefab_item_tags", force: :cascade do |t|
    t.integer "prefab_item_id"
    t.integer "tag_id"
    t.index ["prefab_item_id"], name: "index_prefab_item_tags_on_prefab_item_id"
    t.index ["tag_id"], name: "index_prefab_item_tags_on_tag_id"
  end

  create_table "prefab_items", force: :cascade do |t|
    t.string "name"
  end

  create_table "prefab_store_tags", force: :cascade do |t|
    t.integer "prefab_store_id"
    t.integer "tag_id"
    t.index ["prefab_store_id"], name: "index_prefab_store_tags_on_prefab_store_id"
    t.index ["tag_id"], name: "index_prefab_store_tags_on_tag_id"
  end

  create_table "prefab_stores", force: :cascade do |t|
    t.string "name"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
  end

end
