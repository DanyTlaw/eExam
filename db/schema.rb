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

ActiveRecord::Schema.define(version: 20160705231809) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_of_studies", force: :cascade do |t|
    t.string   "name"
    t.string   "semester"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "course_of_study_id"
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["course_of_study_id"], name: "index_courses_on_course_of_studies_id", using: :btree
  end

  create_table "students", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "email"
    t.boolean  "check"
    t.boolean  "online"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_students_on_course_id", using: :btree
  end

  add_foreign_key "courses", "course_of_studies"
  add_foreign_key "students", "courses"
end
