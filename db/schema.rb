# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120619013847) do

  create_table "exams", :force => true do |t|
    t.string   "name"
    t.boolean  "closed",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qxes", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "qx_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "score_files", :force => true do |t|
    t.string   "filename"
    t.string   "disk_filename"
    t.integer  "filesize"
    t.string   "content_type"
    t.integer  "digest"
    t.integer  "user_id"
    t.integer  "school_id"
    t.integer  "exam_id"
    t.boolean  "confirmed",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.integer  "qx_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.integer  "school_id"
    t.boolean  "is_admin",                                 :default => false
    t.integer  "qx_id"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
