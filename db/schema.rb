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

ActiveRecord::Schema.define(version: 20140319000000) do

  create_table "articles", force: true do |t|
    t.string   "blog_name",          null: false
    t.string   "blog_url",           null: false
    t.string   "blog_etag"
    t.datetime "feed_last_modified"
    t.string   "feed_url"
    t.string   "title",              null: false
    t.string   "url",                null: false
    t.string   "author"
    t.text     "summary"
    t.text     "content"
    t.string   "blog_image"
    t.string   "image"
    t.datetime "published"
    t.string   "entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content_html"
    t.text     "summary_html"
  end

  add_index "articles", ["entry_id"], name: "index_articles_on_entry_id", unique: true, using: :btree
  add_index "articles", ["url"], name: "index_articles_on_url", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.string   "text",             null: false
    t.datetime "created_at"
    t.string   "user_id"
    t.string   "user_name"
    t.string   "user_screen_name"
    t.string   "user_location"
    t.string   "user_url"
    t.string   "user_image_url"
    t.string   "tw_id",            null: false
    t.string   "user_website"
  end

  add_index "tweets", ["tw_id"], name: "index_tweets_on_tw_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
