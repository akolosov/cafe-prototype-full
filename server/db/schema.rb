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

ActiveRecord::Schema.define(:version => 20120520075217) do

  create_table "game_codes", :force => true do |t|
    t.string   "code",       :limit => 3
    t.float    "bonus"
    t.integer  "days"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "group_locales", :force => true do |t|
    t.integer "group_id"
    t.integer "locale_id"
  end

  add_index "group_locales", ["group_id"], :name => "index_group_locales_on_group_id"
  add_index "group_locales", ["locale_id"], :name => "index_group_locales_on_locale_id"

  create_table "groups", :force => true do |t|
    t.integer "group_locales_id"
    t.string  "photo",            :null => false
  end

  create_table "item_locales", :force => true do |t|
    t.integer "item_id"
    t.integer "locale_id"
  end

  add_index "item_locales", ["item_id"], :name => "index_item_locales_on_item_id"
  add_index "item_locales", ["locale_id"], :name => "index_item_locales_on_locale_id"

  create_table "item_properties", :force => true do |t|
    t.integer "item_id"
    t.integer "property_id"
    t.string  "value",       :null => false
  end

  add_index "item_properties", ["item_id"], :name => "index_item_properties_on_item_id"
  add_index "item_properties", ["property_id"], :name => "index_item_properties_on_property_id"

  create_table "items", :force => true do |t|
    t.integer "group_id"
    t.integer "item_locales_id"
    t.string  "photo",           :null => false
  end

  add_index "items", ["group_id"], :name => "index_items_on_group_id"

  create_table "locales", :force => true do |t|
    t.string "name",        :null => false
    t.text   "description"
    t.string "locale",      :null => false
  end

  create_table "menu_items", :force => true do |t|
    t.integer "menu_id"
    t.integer "item_id"
    t.float   "cost",    :null => false
  end

  add_index "menu_items", ["item_id"], :name => "index_menu_items_on_item_id"
  add_index "menu_items", ["menu_id"], :name => "index_menu_items_on_menu_id"

  create_table "menu_locales", :force => true do |t|
    t.integer "menu_id"
    t.integer "locale_id"
  end

  add_index "menu_locales", ["locale_id"], :name => "index_menu_locales_on_locale_id"
  add_index "menu_locales", ["menu_id"], :name => "index_menu_locales_on_menu_id"

  create_table "menus", :force => true do |t|
    t.integer "menu_locales_id"
    t.date    "startdate"
    t.date    "enddate"
  end

  create_table "order_items", :force => true do |t|
    t.integer "order_id"
    t.integer "menu_item_id"
    t.integer "count",        :null => false
  end

  add_index "order_items", ["menu_item_id"], :name => "index_order_items_on_menu_item_id"
  add_index "order_items", ["order_id"], :name => "index_order_items_on_order_id"

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "session"
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.string   "additions"
    t.string   "status"
    t.boolean  "checked",    :default => false
    t.boolean  "closed",     :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "properties", :force => true do |t|
    t.integer "property_locales_id"
  end

  create_table "property_locales", :force => true do |t|
    t.integer "property_id"
    t.integer "locale_id"
  end

  add_index "property_locales", ["locale_id"], :name => "index_property_locales_on_locale_id"
  add_index "property_locales", ["property_id"], :name => "index_property_locales_on_property_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "user_accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "code",       :limit => 3
    t.float    "bonus"
    t.boolean  "used",                    :default => false
    t.date     "expired_at"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "user_accounts", ["user_id"], :name => "index_user_accounts_on_user_id"

  create_table "user_properties", :force => true do |t|
    t.integer "user_id"
    t.string  "name",     :null => false
    t.string  "phone",    :null => false
    t.string  "address"
    t.date    "birthday"
  end

  add_index "user_properties", ["user_id"], :name => "index_user_properties_on_user_id"

  create_table "user_providers", :force => true do |t|
    t.integer "user_id",  :null => false
    t.string  "provider", :null => false
    t.string  "uid",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                          :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "activation_state"
    t.string   "activation_code"
    t.datetime "activation_code_expires_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.integer  "failed_logins_count",             :default => 0
    t.datetime "lock_expires_at"
    t.string   "unlock_token"
    t.string   "roles"
    t.string   "session"
  end

  add_index "users", ["activation_code"], :name => "index_users_on_activation_code"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
