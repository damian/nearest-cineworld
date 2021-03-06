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

ActiveRecord::Schema.define(:version => 20120317214321) do

  create_table "cinemas", :force => true do |t|
    t.integer  "cinema_id"
    t.string   "name"
    t.string   "cinema_url"
    t.text     "address"
    t.string   "postcode"
    t.string   "telephone"
    t.float    "lat"
    t.float    "lng"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cinemas", ["cached_slug"], :name => "index_cinemas_on_cached_slug", :unique => true
  add_index "cinemas", ["cinema_id"], :name => "index_cinemas_on_cinema_id", :unique => true

  create_table "films", :force => true do |t|
    t.integer  "edi"
    t.string   "title"
    t.string   "poster_url"
    t.string   "film_url"
    t.string   "still_url"
    t.string   "advisory"
    t.string   "classification"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imdb_id"
    t.string   "tmdb_url"
    t.text     "overview"
    t.text     "posters"
    t.text     "backdrops"
    t.date     "release_date"
    t.integer  "popularity"
    t.integer  "votes"
    t.float    "rating"
    t.text     "cast"
    t.text     "genres"
    t.string   "trailer_url"
    t.string   "homepage_url"
  end

  add_index "films", ["cached_slug"], :name => "index_films_on_cached_slug", :unique => true
  add_index "films", ["edi"], :name => "index_films_on_edi", :unique => true

  create_table "performances", :force => true do |t|
    t.string   "time"
    t.string   "performance_type"
    t.string   "booking_url"
    t.boolean  "available"
    t.boolean  "ad"
    t.boolean  "subtitled"
    t.datetime "date"
    t.integer  "film_id"
    t.integer  "cinema_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "performances", ["cinema_id"], :name => "index_performances_on_cinema_id"
  add_index "performances", ["date"], :name => "index_performances_on_date"
  add_index "performances", ["film_id"], :name => "index_performances_on_film_id"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
    t.string   "scope"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

end
