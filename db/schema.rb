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

ActiveRecord::Schema.define(version: 20140506115528) do

  create_table "bills", force: true do |t|
    t.string   "number",                               null: false
    t.date     "date",                                 null: false
    t.decimal  "month"
    t.decimal  "year"
    t.decimal  "amount",      precision: 10, scale: 2, null: false
    t.boolean  "paid"
    t.text     "comment"
    t.integer  "customer_id",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "email",      null: false
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name",                                                 null: false
    t.decimal  "timebudget",  precision: 10, scale: 2
    t.text     "comment"
    t.integer  "customer_id",                                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "wage",        precision: 10, scale: 2
    t.boolean  "archived",                             default: false
  end

  create_table "projects_users", force: true do |t|
    t.integer  "project_id",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "project_token"
    t.string   "confirmation_email"
  end

  create_table "reports", force: true do |t|
    t.date     "date",                                                null: false
    t.decimal  "duration",   precision: 10, scale: 2
    t.text     "comment"
    t.integer  "project_id",                                          null: false
    t.integer  "service_id",                                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "wage",       precision: 10, scale: 2
    t.boolean  "archived",                            default: false
  end

  create_table "services", force: true do |t|
    t.string   "name",                                               null: false
    t.decimal  "wage",       precision: 10, scale: 2
    t.boolean  "billable",                            default: true
    t.text     "comment"
    t.integer  "user_id",                                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "login",                               null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email",                               null: false
    t.string   "phone_number"
    t.string   "street"
    t.string   "street_number"
    t.string   "zipcode"
    t.string   "city"
    t.string   "country"
    t.string   "signature"
    t.text     "comment"
    t.integer  "roles_mask"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
