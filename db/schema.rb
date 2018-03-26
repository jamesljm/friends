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

ActiveRecord::Schema.define(version: 2018_03_25_102627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friends", force: :cascade do |t|
    t.integer "user1_id"
    t.integer "user2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user1_id", "user2_id"], name: "index_friends_on_user1_id_and_user2_id", unique: true
    t.index ["user1_id"], name: "index_friends_on_user1_id"
    t.index ["user2_id"], name: "index_friends_on_user2_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone"
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "status"
    t.string "address"
  end

end
