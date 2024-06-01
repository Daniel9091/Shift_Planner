# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_01_174900) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "itineraries", force: :cascade do |t|
    t.string "status", null: false
    t.boolean "is_active", default: true, null: false
    t.string "day", null: false
    t.string "h_start", null: false
    t.string "h_end", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "starting_place_id", null: false
    t.bigint "ending_place_id", null: false
    t.index ["ending_place_id"], name: "index_itineraries_on_ending_place_id"
    t.index ["starting_place_id"], name: "index_itineraries_on_starting_place_id"
    t.index ["user_id"], name: "index_itineraries_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "section_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_group_id"], name: "index_memberships_on_section_group_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "section_groups", force: :cascade do |t|
    t.string "n_seats", null: false
    t.integer "cost", null: false
    t.string "h_start", null: false
    t.string "h_end", null: false
    t.string "day", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "starting_place_id", null: false
    t.bigint "ending_place_id", null: false
    t.bigint "itinerary_id", null: false
    t.index ["ending_place_id"], name: "index_section_groups_on_ending_place_id"
    t.index ["itinerary_id"], name: "index_section_groups_on_itinerary_id"
    t.index ["starting_place_id"], name: "index_section_groups_on_starting_place_id"
    t.index ["user_id"], name: "index_section_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "phone", null: false
    t.string "description"
    t.string "data_name"
    t.string "data_rut"
    t.string "account_type"
    t.string "n_account"
    t.string "banc"
    t.string "data_email"
    t.integer "driver_review", default: 1
    t.integer "n_driver_review", default: 0
    t.integer "passenger_review", default: 1
    t.integer "n_passenger_review", default: 0
    t.boolean "first_login", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "itineraries", "places", column: "ending_place_id"
  add_foreign_key "itineraries", "places", column: "starting_place_id"
  add_foreign_key "itineraries", "users"
  add_foreign_key "memberships", "section_groups"
  add_foreign_key "memberships", "users"
  add_foreign_key "section_groups", "itineraries"
  add_foreign_key "section_groups", "places", column: "ending_place_id"
  add_foreign_key "section_groups", "places", column: "starting_place_id"
  add_foreign_key "section_groups", "users"
end
