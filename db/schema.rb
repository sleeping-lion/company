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

ActiveRecord::Schema.define(version: 20130324093627) do

  create_table "faq_categories", force: true do |t|
    t.string   "title",                     null: false
    t.boolean  "enable",     default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faq_contents", force: true do |t|
    t.boolean "html",    default: false, null: false
    t.string  "content"
  end

  create_table "faqs", force: true do |t|
    t.integer  "faq_category_id",                null: false
    t.string   "title",                          null: false
    t.integer  "count",           default: 0,    null: false
    t.boolean  "enable",          default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faqs", ["faq_category_id"], name: "index_faqs_on_faq_category_id"

  create_table "galleries", force: true do |t|
    t.integer  "gallery_category_id",                null: false
    t.string   "title",                              null: false
    t.string   "photo",                              null: false
    t.text     "content",                            null: false
    t.boolean  "enable",              default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "galleries", ["gallery_category_id"], name: "index_galleries_on_gallery_category_id"

  create_table "gallery_categories", force: true do |t|
    t.string   "title",                     null: false
    t.boolean  "enable",     default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guest_book_comments", force: true do |t|
    t.integer  "guest_book_id",                 null: false
    t.integer  "user_id"
    t.string   "name"
    t.string   "encrypted_password", limit: 40
    t.string   "salt"
    t.text     "content",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guest_book_comments", ["guest_book_id"], name: "index_guest_book_comments_on_guest_book_id"
  add_index "guest_book_comments", ["user_id"], name: "index_guest_book_comments_on_user_id"

  create_table "guest_book_contents", force: true do |t|
    t.text "content", null: false
  end

  create_table "guest_books", force: true do |t|
    t.integer  "user_id"
    t.string   "title",                     limit: 60,                null: false
    t.string   "name",                      limit: 60
    t.string   "encrypted_password",        limit: 40
    t.string   "salt"
    t.integer  "guest_book_comments_count",            default: 0,    null: false
    t.boolean  "enable",                               default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guest_books", ["user_id"], name: "index_guest_books_on_user_id"

  create_table "histories", force: true do |t|
    t.integer  "user_id",               null: false
    t.string   "year",       limit: 40, null: false
    t.string   "title",      limit: 60, null: false
    t.text     "content",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "histories", ["user_id"], name: "index_histories_on_user_id"

  create_table "impressions", force: true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id"

  create_table "maintain", force: true do |t|
    t.string   "title",      limit: 60,                null: false
    t.string   "photo"
    t.boolean  "enable",                default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maintain_contents", force: true do |t|
    t.text "content", null: false
  end

  create_table "notice_contents", force: true do |t|
    t.text "content", null: false
  end

  create_table "notices", force: true do |t|
    t.integer  "user_id",               null: false
    t.string   "title",      limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notices", ["user_id"], name: "index_notices_on_user_id"

  create_table "portfolio_contents", force: true do |t|
    t.text "content", null: false
  end

  create_table "portfolios", force: true do |t|
    t.string   "title",                      null: false
    t.string   "url",                        null: false
    t.text     "description",                null: false
    t.string   "photo",                      null: false
    t.boolean  "enable",      default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_contents", force: true do |t|
    t.boolean "html",    default: false, null: false
    t.text    "content",                 null: false
  end

  create_table "product_options", force: true do |t|
    t.string   "title",       limit: 60, null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "title",          default: "0",   null: false
    t.integer  "price",          default: 0,     null: false
    t.integer  "price_discount", default: 0,     null: false
    t.integer  "page",           default: 0,     null: false
    t.string   "description",                    null: false
    t.string   "program"
    t.string   "photo"
    t.integer  "make_day",       default: 7,     null: false
    t.boolean  "full",           default: false, null: false
    t.boolean  "main_show",      default: false, null: false
    t.boolean  "enable",         default: true,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "title",       limit: 60,                null: false
    t.string   "description",                           null: false
    t.string   "photo"
    t.boolean  "enable",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_comments", force: true do |t|
    t.integer  "question_id",                   null: false
    t.integer  "user_id"
    t.string   "name"
    t.string   "encrypted_password", limit: 40
    t.string   "salt"
    t.text     "content",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "question_comments", ["question_id"], name: "index_question_comments_on_question_id"
  add_index "question_comments", ["user_id"], name: "index_question_comments_on_user_id"

  create_table "question_contents", force: true do |t|
    t.text "content", null: false
  end

  create_table "questions", force: true do |t|
    t.integer  "user_id"
    t.string   "title",                   limit: 60,                null: false
    t.string   "name",                    limit: 60
    t.string   "encrypted_password",      limit: 40
    t.string   "salt"
    t.integer  "secret",                             default: 0,    null: false
    t.integer  "question_comments_count",            default: 0,    null: false
    t.boolean  "enable",                             default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "resource_photos", force: true do |t|
    t.integer  "resource_id",                           null: false
    t.string   "photo",                                 null: false
    t.string   "alt",         limit: 60,                null: false
    t.boolean  "enable",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resource_photos", ["resource_id"], name: "index_resource_photos_on_resource_id"

  create_table "resources", force: true do |t|
    t.integer  "ad_position_id",                              null: false
    t.string   "title",          limit: 60,                   null: false
    t.string   "description"
    t.string   "controller",     limit: 60,                   null: false
    t.string   "menu_action",    limit: 60, default: "index", null: false
    t.boolean  "use_category",              default: false,   null: false
    t.boolean  "menu_display",              default: true,    null: false
    t.integer  "per",                       default: 10,      null: false
    t.boolean  "desc",                      default: true,    null: false
    t.boolean  "enable",                    default: true,    null: false
    t.integer  "priority",                  default: 100,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resources", ["ad_position_id"], name: "index_resources_on_ad_position_id"
  add_index "resources", ["controller"], name: "index_resources_on_controller", unique: true
  add_index "resources", ["title"], name: "index_resources_on_title", unique: true

  create_table "template_authors", force: true do |t|
    t.string   "name",                                  null: false
    t.string   "korean_name", limit: 60
    t.boolean  "enable",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "template_categories", force: true do |t|
    t.string   "name",        limit: 60,                null: false
    t.string   "korean_name", limit: 60
    t.integer  "count",                  default: 0,    null: false
    t.boolean  "enable",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "template_categories_templates", id: false, force: true do |t|
    t.integer "template_id"
    t.integer "template_category_id"
  end

  create_table "template_packages", force: true do |t|
    t.string   "name",                                  null: false
    t.string   "korean_name", limit: 60
    t.boolean  "enable",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "template_screenshots", force: true do |t|
    t.integer  "template_id"
    t.string   "uri",                           null: false
    t.boolean  "small_preview", default: false, null: false
    t.boolean  "main_preview",  default: false, null: false
    t.boolean  "enable",        default: true,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "template_screenshots", ["template_id"], name: "index_template_screenshots_on_template_id"

  create_table "template_softwares", force: true do |t|
    t.string   "name",                                  null: false
    t.string   "korean_name", limit: 60
    t.boolean  "enable",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "template_softwares_templates", id: false, force: true do |t|
    t.integer "template_id"
    t.integer "template_software_id"
  end

  create_table "template_sources", force: true do |t|
    t.string   "name",                                  null: false
    t.string   "korean_name", limit: 60
    t.boolean  "enable",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "template_sources_templates", id: false, force: true do |t|
    t.integer "template_id"
    t.integer "template_source_id"
  end

  create_table "template_types", force: true do |t|
    t.integer  "product_id"
    t.string   "name",        limit: 60,                null: false
    t.string   "korean_name", limit: 60
    t.boolean  "enable",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "template_types", ["product_id"], name: "index_template_types_on_product_id"

  create_table "templates", force: true do |t|
    t.string   "title",               limit: 60
    t.integer  "template_type_id",                               null: false
    t.integer  "template_author_id",                             null: false
    t.integer  "template_package_id",                            null: false
    t.integer  "state",                          default: 0,     null: false
    t.integer  "price",                          default: 0,     null: false
    t.integer  "exc_price",                      default: 0,     null: false
    t.integer  "downloads",                      default: 0,     null: false
    t.boolean  "is_flash",                       default: false, null: false
    t.boolean  "is_adult",                       default: false, null: false
    t.boolean  "is_full_site",                   default: false, null: false
    t.boolean  "is_real_size",                   default: false, null: false
    t.boolean  "is_recommend",                   default: false, null: false
    t.boolean  "is_main",                        default: false, null: false
    t.datetime "inserted_date"
    t.datetime "update_date"
    t.string   "keywords"
    t.string   "main_screenshot"
    t.string   "small_screenshot"
    t.boolean  "enable",                         default: true,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "templates", ["template_author_id"], name: "index_templates_on_template_author_id"
  add_index "templates", ["template_package_id"], name: "index_templates_on_template_package_id"
  add_index "templates", ["template_type_id"], name: "index_templates_on_template_type_id"

  create_table "users", force: true do |t|
    t.string   "email",                              null: false
    t.string   "name",                               null: false
    t.string   "encrypted_password",                 null: false
    t.string   "photo"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "admin",                  default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
