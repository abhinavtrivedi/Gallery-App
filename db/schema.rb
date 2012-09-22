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

ActiveRecord::Schema.define(:version => 20120922075222) do

  create_table "artifacts", :force => true do |t|
    t.string   "title"
    t.integer  "artist_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "user_id"
    t.string   "sample_file_name"
    t.string   "sample_content_type"
    t.integer  "sample_file_size"
    t.datetime "sample_updated_at"
    t.string   "description"
    t.integer  "price"
    t.integer  "bid_price"
    t.datetime "bid_at"
    t.integer  "bid_user_id"
    t.integer  "comment_count"
  end

  add_index "artifacts", ["user_id"], :name => "index_artifacts_on_user_id"

  create_table "comments", :force => true do |t|
    t.string   "comment_text"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "artifact_id"
    t.string   "user_id"
  end

  add_index "comments", ["artifact_id"], :name => "index_comments_on_artifact_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "artifact_count"
    t.boolean  "is_admin"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
