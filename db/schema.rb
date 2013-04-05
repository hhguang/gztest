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

ActiveRecord::Schema.define(:version => 20130328034707) do

  create_table "exams", :force => true do |t|
    t.string   "name"
    t.boolean  "closed",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", :force => true do |t|
    t.integer  "paper_order_id"
    t.integer  "school_id"
    t.string   "school_name"
    t.integer  "g1yw"
    t.integer  "g1sx"
    t.integer  "g1yy"
    t.integer  "g1wl"
    t.integer  "g1hx"
    t.integer  "g1sw"
    t.integer  "g1zz"
    t.integer  "g1ls"
    t.integer  "g1dl"
    t.integer  "g2w"
    t.integer  "g2l"
    t.integer  "g2yw"
    t.integer  "g2sxl"
    t.integer  "g2sxw"
    t.integer  "g2yy"
    t.integer  "g2wl"
    t.integer  "g2hx"
    t.integer  "g2sw"
    t.integer  "g2zz"
    t.integer  "g2ls"
    t.integer  "g2dl"
    t.integer  "g3w"
    t.integer  "g3l"
    t.integer  "g3yw"
    t.integer  "g3sxl"
    t.integer  "g3sxw"
    t.integer  "g3yy"
    t.integer  "g3wz"
    t.integer  "g3lz"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paper_orders", :force => true do |t|
    t.string   "name"
    t.integer  "item_type"
    t.boolean  "current"
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
    t.integer  "f_type"
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
