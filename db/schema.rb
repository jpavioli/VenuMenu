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

ActiveRecord::Schema.define(version: 2019_04_15_201214) do

  create_table "attractions", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "attraction_name"
    t.string "attraction_primary_classification"
    t.string "attraction_secondary_classification"
    t.boolean "attraction_family_classifcation"
  end

  create_table "events", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "event_name"
    t.string "event_tickets_go_on_sale"
    t.string "event_date"
    t.string "event_time"
    t.string "event_ticket_status"
    t.string "venue_id"
    t.string "attraction_id"
  end

  create_table "venues", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "venue_name"
    t.string "venue_postalCode"
    t.string "venue_city"
  end

end
