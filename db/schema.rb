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

ActiveRecord::Schema[7.0].define(version: 2023_08_07_055932) do
  create_table "approval_requests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "status", limit: 1, default: 0, null: false
    t.text "comment"
    t.bigint "user_id", null: false
    t.bigint "family_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_approval_requests_on_family_id"
    t.index ["user_id"], name: "index_approval_requests_on_user_id"
  end

  create_table "approval_statuses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "status", limit: 1, default: 0, null: false
    t.text "comment"
    t.bigint "approval_request_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approval_request_id"], name: "index_approval_statuses_on_approval_request_id"
    t.index ["user_id"], name: "index_approval_statuses_on_user_id"
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "family_id"
    t.index ["family_id"], name: "index_categories_on_family_id"
  end

  create_table "families", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.string "avatar"
    t.integer "budget"
    t.integer "budget_of_last_month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notices", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "notice_type", default: 0, null: false
    t.bigint "family_id", null: false
    t.bigint "user_id", null: false
    t.bigint "approval_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approval_request_id"], name: "index_notices_on_approval_request_id"
    t.index ["family_id"], name: "index_notices_on_family_id"
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "reads", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "checked", default: false
    t.bigint "notice_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notice_id"], name: "index_reads_on_notice_id"
    t.index ["user_id"], name: "index_reads_on_user_id"
  end

  create_table "task_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count", default: 1
    t.bigint "family_id"
    t.index ["family_id"], name: "index_task_users_on_family_id"
    t.index ["task_id"], name: "index_task_users_on_task_id"
    t.index ["user_id"], name: "index_task_users_on_user_id"
  end

  create_table "tasks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "points", null: false
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "family_id"
    t.integer "category_name", default: 0, null: false
    t.index ["category_id"], name: "index_tasks_on_category_id"
    t.index ["family_id"], name: "index_tasks_on_family_id"
  end

  create_table "temporary_family_data", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.string "avatar"
    t.integer "budget"
    t.bigint "approval_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approval_request_id"], name: "index_temporary_family_data_on_approval_request_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "nickname"
    t.string "avatar"
    t.integer "pocket_money"
    t.bigint "family_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["family_id"], name: "index_users_on_family_id"
  end

  add_foreign_key "approval_requests", "families"
  add_foreign_key "approval_requests", "users"
  add_foreign_key "approval_statuses", "approval_requests"
  add_foreign_key "approval_statuses", "users"
  add_foreign_key "categories", "families"
  add_foreign_key "notices", "approval_requests"
  add_foreign_key "notices", "families"
  add_foreign_key "notices", "users"
  add_foreign_key "reads", "notices"
  add_foreign_key "reads", "users"
  add_foreign_key "task_users", "families"
  add_foreign_key "task_users", "tasks"
  add_foreign_key "task_users", "users"
  add_foreign_key "tasks", "categories"
  add_foreign_key "tasks", "families"
  add_foreign_key "temporary_family_data", "approval_requests"
  add_foreign_key "users", "families"
end
