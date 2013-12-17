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

ActiveRecord::Schema.define(:version => 20131217162211) do

  create_table "availabilities", :force => true do |t|
    t.integer  "office_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "deals", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "renter_id"
    t.integer  "office_id"
    t.boolean  "owner_approval"
    t.boolean  "renter_approval"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "price"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "office_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favorites", ["user_id", "office_id"], :name => "index_favorites_on_user_id_and_office_id", :unique => true

  create_table "features", :force => true do |t|
    t.string   "feature_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "features", ["feature_name"], :name => "index_features_on_feature_name", :unique => true

  create_table "featurings", :force => true do |t|
    t.integer  "office_id"
    t.integer  "feature_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "featurings", ["feature_id", "office_id"], :name => "index_featurings_on_feature_id_and_office_id", :unique => true

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "deal_id"
    t.text     "message_body"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "offices", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "addr1"
    t.string   "addr2"
    t.string   "city"
    t.string   "zip"
    t.integer  "size"
    t.integer  "owner_id"
    t.boolean  "available"
    t.integer  "occupancy"
    t.integer  "price"
    t.string   "arrangement"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "state"
    t.string   "website"
    t.float    "latitude"
    t.float    "longitute"
  end

  create_table "photos", :force => true do |t|
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "office_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "office_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "taggings", ["tag_id", "office_id"], :name => "index_taggings_on_tag_id_and_office_id", :unique => true

  create_table "tags", :force => true do |t|
    t.string   "tag_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["tag_name"], :name => "index_tags_on_tag_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "session"
    t.string   "city"
    t.string   "phone_number"
    t.string   "business_name"
    t.text     "business_description"
    t.string   "password_digest"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "website"
    t.float    "latitude"
    t.float    "longitute"
  end

end
