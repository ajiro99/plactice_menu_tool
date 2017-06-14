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

ActiveRecord::Schema.define(version: 20170326082642) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "practice_contents", force: :cascade do |t|
    t.integer  "category_id",                null: false
    t.string   "practice_name",              null: false
    t.string   "head_count"
    t.string   "estimated_time"
    t.text     "concept"
    t.text     "rule"
    t.text     "remarks"
    t.integer  "strength",       default: 0
    t.string   "url"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "practice_contents", ["category_id"], name: "index_practice_contents_on_category_id"

  create_table "practice_menu_sets", force: :cascade do |t|
    t.integer  "practice_schedule_id", null: false
    t.integer  "practice_content_id",  null: false
    t.integer  "order",                null: false
    t.integer  "time",                 null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "practice_menu_sets", ["practice_content_id"], name: "index_practice_menu_sets_on_practice_content_id"
  add_index "practice_menu_sets", ["practice_schedule_id"], name: "index_practice_menu_sets_on_practice_schedule_id"

  create_table "practice_schedules", force: :cascade do |t|
    t.datetime "practice_date",             null: false
    t.time     "practice_time",             null: false
    t.integer  "fp_count",      default: 0
    t.integer  "gk_count",      default: 0
    t.string   "place"
    t.text     "remarks"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
