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

ActiveRecord::Schema.define(version: 20140223044752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: true do |t|
    t.integer  "user_id"
    t.integer  "brokerage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brokerages", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brokers", force: true do |t|
    t.integer  "user_id"
    t.integer  "brokerage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leads", force: true do |t|
    t.integer  "user_id"
    t.integer  "sending_agent_id"
    t.integer  "receiving_agent_id"
    t.boolean  "accepted_by_agent"
    t.datetime "accepted_by_agent_time"
    t.boolean  "accepted_by_broker"
    t.datetime "accepted_by_broker_time"
    t.boolean  "selling"
    t.boolean  "buying"
    t.integer  "price_range_start"
    t.integer  "price_range_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.string   "password"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
