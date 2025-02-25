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

ActiveRecord::Schema[8.0].define(version: 2025_02_20_193549) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "tasks_priority_options", ["low", "medium", "high"]
  create_enum "tasks_status_options", ["not_started", "in_progress", "completed", "blocked"]

  create_table "employees", force: :cascade do |t|
    t.bigint "org_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.text "types"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["org_id"], name: "index_employees_on_org_id"
  end

  create_table "orgs", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "due_date"
    t.bigint "org_id", null: false
    t.bigint "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "priority", null: false, enum_type: "tasks_priority_options"
    t.enum "status", null: false, enum_type: "tasks_status_options"
    t.index ["employee_id"], name: "index_tasks_on_employee_id"
    t.index ["org_id"], name: "index_tasks_on_org_id"
  end

  add_foreign_key "employees", "orgs"
  add_foreign_key "tasks", "employees"
  add_foreign_key "tasks", "orgs"
end
