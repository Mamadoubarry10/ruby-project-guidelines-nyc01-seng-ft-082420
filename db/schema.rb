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

ActiveRecord::Schema.define(version: 2020_09_08_212121) do

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "venue"
    t.datetime "date"
    t.float "price"
    t.string "event_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "password"
    t.string "city"
  end

end
