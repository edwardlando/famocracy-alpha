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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120430032209) do

  create_table "agents", :force => true do |t|
    t.integer  "user_id"
    t.integer  "money"
    t.integer  "level"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "agents", ["user_id"], :name => "index_agents_on_user_id"

  create_table "artists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "money"
    t.integer  "level"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "artists", ["user_id"], :name => "index_artists_on_user_id"

  create_table "investments", :force => true do |t|
    t.integer  "artist_id"
    t.integer  "agent_id"
    t.integer  "amount"
    t.date     "invested"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "investments", ["agent_id"], :name => "index_investments_on_agent_id"
  add_index "investments", ["artist_id"], :name => "index_investments_on_artist_id"

  create_table "jobs", :force => true do |t|
    t.string   "description"
    t.integer  "pay"
    t.date     "due"
    t.integer  "employer_id"
    t.integer  "employee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "name",                                   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "title",                     :null => false
    t.string   "link",                      :null => false
    t.integer  "views",      :default => 0
    t.integer  "artist_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

end
