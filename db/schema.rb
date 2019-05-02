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

ActiveRecord::Schema.define(version: 2019_05_01_234024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "merchants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "email"
    t.integer "uid"
    t.string "provider"
  end

  create_table "order_products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.index ["order_id"], name: "index_order_products_on_order_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "email"
    t.string "address1"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.integer "last_four_cc"
    t.string "expiration"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.boolean "retired", default: false
    t.string "description"
    t.bigint "merchant_id"
    t.index ["merchant_id"], name: "index_products_on_merchant_id"
  end

  add_foreign_key "products", "merchants"
end
