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

ActiveRecord::Schema.define(version: 2019_02_16_145516) do

  create_table "questions", force: :cascade do |t|
    t.integer "user_id"
    t.string "author"
    t.string "quiz"
    t.string "choice1"
    t.string "choice2"
    t.string "choice3"
    t.integer "answer"
    t.boolean "clear", default: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "mentor_name"
    t.integer "month"
    t.integer "date"
    t.integer "score", default: 0
    t.boolean "clear", default: false
  end

  create_table "videos", force: :cascade do |t|
    t.integer "user_id"
    t.string "author"
    t.string "url"
    t.boolean "played", default: false
    t.index ["user_id"], name: "index_videos_on_user_id"
  end

end
