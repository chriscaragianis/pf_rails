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

ActiveRecord::Schema.define(version: 20160415173432) do

  create_table "accounts", force: :cascade do |t|
    t.float    "rate"
    t.float    "balance"
    t.float    "min_floor"
    t.float    "min_rate"
    t.string   "acct_name"
    t.boolean  "weekly"
    t.integer  "week_offset"
    t.integer  "week_period"
    t.integer  "day"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "fixed_amount"
    t.boolean  "carry_balance"
    t.integer  "vest_priority"
    t.integer  "scenario_id"
    t.integer  "user_id"
  end

  create_table "plan_accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id"
    t.integer  "plan_id"
  end

  add_index "plan_accounts", ["account_id"], name: "index_plan_accounts_on_account_id"
  add_index "plan_accounts", ["plan_id"], name: "index_plan_accounts_on_plan_id"

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.float    "vest_level"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "start_balance"
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
