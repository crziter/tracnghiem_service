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

ActiveRecord::Schema.define(version: 20141026174134) do

  create_table "cau_hois", force: true do |t|
    t.text     "noi_dung"
    t.text     "a"
    t.text     "b"
    t.text     "c"
    t.text     "d"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dap_ans", force: true do |t|
    t.integer  "cau_hoi_id"
    t.integer  "dap_an"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "de_thi_cau_hois", force: true do |t|
    t.integer  "cau_hoi_id"
    t.integer  "de_thi_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "de_this", force: true do |t|
    t.integer  "mon_thi_id"
    t.date     "ngay_tao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ket_quas", force: true do |t|
    t.integer  "cau_hoi_id"
    t.integer  "thi_id"
    t.integer  "tra_loi"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mon_this", force: true do |t|
    t.string   "ten"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "thi_sinhs", force: true do |t|
    t.string   "ten_dang_nhap"
    t.string   "mat_khau"
    t.string   "ten_that"
    t.date     "ngay_sinh"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "this", force: true do |t|
    t.integer  "thi_sinh_id"
    t.integer  "de_thi_id"
    t.datetime "thoi_gian_bat_dau"
    t.datetime "thoi_gian_ket_thuc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
