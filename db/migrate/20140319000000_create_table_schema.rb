class CreateTableSchema < ActiveRecord::Migration
  def change
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
end
