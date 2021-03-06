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

ActiveRecord::Schema.define(version: 2020_09_19_120437) do

  create_table "gym_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "gym_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gym_id"], name: "index_gym_users_on_gym_id"
    t.index ["user_id", "gym_id"], name: "index_gym_users_on_user_id_and_gym_id", unique: true
    t.index ["user_id"], name: "index_gym_users_on_user_id"
  end

  create_table "gyms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "img"
    t.string "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin_user_id"
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "content"
    t.string "img"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "gym_id", null: false
    t.index ["gym_id"], name: "index_posts_on_gym_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "trainings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "part1", default: 0
    t.integer "part2", default: 0
    t.integer "part3", default: 0
    t.bigint "user_id", null: false
    t.bigint "gym_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "partner", default: "なし"
    t.index ["gym_id"], name: "index_trainings_on_gym_id"
    t.index ["user_id"], name: "index_trainings_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "img"
    t.string "status"
    t.integer "purpose", default: 0
    t.string "twitter"
  end

  add_foreign_key "gym_users", "gyms"
  add_foreign_key "gym_users", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "trainings", "gyms"
  add_foreign_key "trainings", "users"
end
