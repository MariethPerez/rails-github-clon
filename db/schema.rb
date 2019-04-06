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

ActiveRecord::Schema.define(version: 2019_04_05_191017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.bigint "repository_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_branches_on_repository_id"
    t.index ["user_id"], name: "index_branches_on_user_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "label"
    t.bigint "user_create_id"
    t.bigint "user_assign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "repository_id"
    t.index ["repository_id"], name: "index_issues_on_repository_id"
    t.index ["user_assign_id"], name: "index_issues_on_user_assign_id"
    t.index ["user_create_id"], name: "index_issues_on_user_create_id"
  end

  create_table "pull_requests", force: :cascade do |t|
    t.string "title"
    t.string "status"
    t.text "description"
    t.bigint "branch_in_id"
    t.bigint "branch_out_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_in_id"], name: "index_pull_requests_on_branch_in_id"
    t.index ["branch_out_id"], name: "index_pull_requests_on_branch_out_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "access"
    t.string "license"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.date "birthday"
    t.string "email"
    t.text "bio"
    t.string "company"
    t.string "location"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "branches", "repositories"
  add_foreign_key "branches", "users"
  add_foreign_key "issues", "repositories"
  add_foreign_key "repositories", "users"
end
