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

ActiveRecord::Schema.define(version: 20160624202218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "borrowers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "reason"
    t.text     "description"
    t.float    "amount_needed"
    t.float    "amount_received"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "lenders", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.float    "balance"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "borrower_id"
    t.integer  "lender_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "amount"
  end

  add_index "transactions", ["borrower_id"], name: "index_transactions_on_borrower_id", using: :btree
  add_index "transactions", ["lender_id"], name: "index_transactions_on_lender_id", using: :btree

  add_foreign_key "transactions", "borrowers"
  add_foreign_key "transactions", "lenders"
end