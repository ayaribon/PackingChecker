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

ActiveRecord::Schema[7.2].define(version: 2024_09_13_161309) do
  create_table "packing_tips", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.date "due"
    t.string "status", default: "pending", null: false
    t.string "baggage", default: "carry", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "travel_plan_id"
    t.boolean "is_template"
    t.boolean "public", default: false
    t.index ["travel_plan_id"], name: "index_tasks_on_travel_plan_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "travel_plans", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "country"
    t.text "note"
    t.date "due"
    t.bigint "user_id"
    t.bigint "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_template", default: false, null: false
    t.boolean "public", default: false
    t.boolean "completed", default: false
    t.index ["task_id"], name: "index_travel_plans_on_task_id"
    t.index ["user_id"], name: "index_travel_plans_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "tasks", "travel_plans"
  add_foreign_key "tasks", "users"
  add_foreign_key "travel_plans", "tasks"
  add_foreign_key "travel_plans", "users"
end
