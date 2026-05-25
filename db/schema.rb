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

ActiveRecord::Schema[8.1].define(version: 2026_03_10_105051) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "batches", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.bigint "creator_id", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_batches_on_course_id"
    t.index ["creator_id"], name: "index_batches_on_creator_id"
  end

  create_table "courses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "creator_id", null: false
    t.text "description"
    t.string "name"
    t.bigint "school_id", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_courses_on_creator_id"
    t.index ["school_id"], name: "index_courses_on_school_id"
  end

  create_table "enrollment_requests", force: :cascade do |t|
    t.bigint "batch_id", null: false
    t.datetime "created_at", null: false
    t.string "status", default: "pending"
    t.bigint "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id"], name: "index_enrollment_requests_on_batch_id"
    t.index ["student_id", "batch_id"], name: "index_enrollment_requests_on_student_id_and_batch_id", unique: true
    t.index ["student_id"], name: "index_enrollment_requests_on_student_id"
  end

  create_table "schools", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "location"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role"
    t.bigint "school_id"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_users_on_school_id"
  end

  add_foreign_key "batches", "courses"
  add_foreign_key "batches", "users", column: "creator_id"
  add_foreign_key "courses", "schools"
  add_foreign_key "courses", "users", column: "creator_id"
  add_foreign_key "enrollment_requests", "batches"
  add_foreign_key "enrollment_requests", "users", column: "student_id"
  add_foreign_key "users", "schools"
end
