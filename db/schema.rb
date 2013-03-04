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

ActiveRecord::Schema.define(:version => 20130225224453) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.integer  "school_id"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "classrooms", :force => true do |t|
    t.string   "name"
    t.string   "grade"
    t.integer  "school_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "teacher_id"
  end

  create_table "parents", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.integer  "school_id"
  end

  add_index "parents", ["email"], :name => "index_parents_on_email", :unique => true
  add_index "parents", ["reset_password_token"], :name => "index_parents_on_reset_password_token", :unique => true

  create_table "parents_students", :id => false, :force => true do |t|
    t.integer "parent_id"
    t.integer "student_id"
  end

  create_table "question_results", :force => true do |t|
    t.integer  "question_id"
    t.integer  "quiz_result_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "answer"
  end

  create_table "questions", :force => true do |t|
    t.string   "question"
    t.string   "answer_a"
    t.string   "answer_b"
    t.string   "answer_c"
    t.string   "answer_d"
    t.integer  "quiz_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "correct"
  end

  create_table "quiz_results", :force => true do |t|
    t.boolean  "published"
    t.datetime "date"
    t.integer  "student_id"
    t.integer  "quiz_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "grade"
    t.integer  "ocurrence"
  end

  create_table "quizzes", :force => true do |t|
    t.string   "title"
    t.datetime "stdate"
    t.datetime "enddate"
    t.integer  "teacher_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "published"
    t.integer  "ocurrences"
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "picture"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "time_zone"
  end

  create_table "students", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.integer  "classroom_id"
    t.integer  "school_id"
  end

  add_index "students", ["email"], :name => "index_students_on_email", :unique => true
  add_index "students", ["reset_password_token"], :name => "index_students_on_reset_password_token", :unique => true

  create_table "teachers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.integer  "school_id"
  end

  add_index "teachers", ["email"], :name => "index_teachers_on_email", :unique => true
  add_index "teachers", ["reset_password_token"], :name => "index_teachers_on_reset_password_token", :unique => true

end
