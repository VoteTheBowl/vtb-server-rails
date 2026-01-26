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

ActiveRecord::Schema[8.1].define(version: 2026_01_26_210850) do
  create_table "ballots", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "event_id", null: false
    t.datetime "submitted"
    t.string "token"
    t.datetime "updated_at", null: false
    t.string "vote"
    t.string "voter_name"
    t.index ["event_id"], name: "index_ballots_on_event_id"
    t.index ["voter_name", "event_id"], name: "index_ballots_on_voter_name_and_event_id", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "choices"
    t.datetime "closed"
    t.datetime "created_at", null: false
    t.string "electoral_system"
    t.string "host_token"
    t.string "name"
    t.string "share_token"
    t.boolean "show_results"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ballots", "events"
end
