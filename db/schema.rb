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

ActiveRecord::Schema[7.0].define(version: 2023_07_21_190928) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "inquiries", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "email"
    t.string "organization"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pitches", force: :cascade do |t|
    t.datetime "pitch_time", precision: nil
    t.integer "x"
    t.integer "y"
    t.integer "s"
    t.boolean "is_strike"
    t.text "sign"
    t.integer "session_id"
    t.datetime "create_time", precision: nil
    t.datetime "update_time", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.text "relay_device_guid"
    t.text "relay_description"
    t.text "pitch_analyzer"
    t.text "description"
    t.boolean "current_session"
    t.datetime "start_time", precision: nil
    t.text "pitcher_id"
    t.datetime "create_time", precision: nil
    t.datetime "update_time", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_relay_registrations", force: :cascade do |t|
    t.text "user_id"
    t.text "device_guid"
    t.text "device_description"
    t.integer "usage_count"
    t.datetime "create_time", precision: nil
    t.datetime "update_time", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "user_id"
    t.text "first_name"
    t.text "last_name"
    t.text "nick_name"
    t.text "cell_number"
    t.text "passwd_hash"
    t.integer "pin"
    t.integer "age_at_signup"
    t.datetime "date_of_signup", precision: nil
    t.boolean "admin_flg"
    t.datetime "create_time", precision: nil
    t.datetime "update_time", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
