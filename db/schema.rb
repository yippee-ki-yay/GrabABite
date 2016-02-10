# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160204202403) do

  create_table "friends", id: false, force: :cascade do |t|
    t.integer "user_a", limit: 4, null: false
    t.integer "user_b", limit: 4, null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "desc",       limit: 65535
    t.float    "price",      limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "items_restaurants", id: false, force: :cascade do |t|
    t.integer "restaurant_id", limit: 4, null: false
    t.integer "item_id",       limit: 4, null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "desc",       limit: 255
    t.string   "address",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  add_index "restaurants", ["user_id"], name: "index_restaurants_on_user_id", using: :btree

  create_table "restaurants_tables", id: false, force: :cascade do |t|
    t.integer "restaurant_id", limit: 4, null: false
    t.integer "table_id",      limit: 4, null: false
  end

  create_table "tables", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "row",        limit: 4
    t.integer  "column",     limit: 4
    t.integer  "capacity",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_visits", force: :cascade do |t|
    t.integer  "score",      limit: 4
    t.integer  "visit_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_visits", ["user_id"], name: "index_user_visits_on_user_id", using: :btree
  add_index "user_visits", ["visit_id"], name: "index_user_visits_on_visit_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visits", force: :cascade do |t|
    t.datetime "start_date"
    t.time     "duration"
    t.integer  "restaurant_id", limit: 4
    t.integer  "table_id",      limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "visits", ["restaurant_id"], name: "index_visits_on_restaurant_id", using: :btree
  add_index "visits", ["table_id"], name: "index_visits_on_table_id", using: :btree

  add_foreign_key "user_visits", "users"
  add_foreign_key "user_visits", "visits"
  add_foreign_key "visits", "restaurants"
  add_foreign_key "visits", "tables"
end
