# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_25_161234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pitches", force: :cascade do |t|
    t.datetime "pitch_time"
    t.integer "x"
    t.integer "y"
    t.integer "s"
    t.boolean "is_strike"
    t.text "sign"
    t.integer "session_id"
    t.datetime "create_time"
    t.datetime "update_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.text "relay_device_guid"
    t.text "relay_description"
    t.text "pitch_analyzer"
    t.text "description"
    t.boolean "current_session"
    t.datetime "start_time"
    t.text "pitcher_id"
    t.datetime "create_time"
    t.datetime "update_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_relay_registrations", force: :cascade do |t|
    t.text "user_id"
    t.text "device_guid"
    t.text "device_description"
    t.integer "usage_count"
    t.datetime "create_time"
    t.datetime "update_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "user_id"
    t.text "first_name"
    t.text "last_name"
    t.text "nick_name"
    t.text "email"
    t.text "cell_number"
    t.text "passwd_hash"
    t.integer "pin"
    t.integer "age_at_signup"
    t.datetime "date_of_signup"
    t.boolean "admin_flg"
    t.datetime "create_time"
    t.datetime "update_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  end

end
