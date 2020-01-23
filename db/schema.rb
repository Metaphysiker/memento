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

ActiveRecord::Schema.define(version: 2019_12_12_074240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "line1", default: ""
    t.string "line2", default: ""
    t.string "line3", default: ""
    t.string "line4", default: ""
    t.string "line5", default: ""
    t.string "street", default: ""
    t.string "plz", default: ""
    t.string "location", default: ""
    t.string "country", default: ""
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "affiliations", force: :cascade do |t|
    t.bigint "institution_id"
    t.bigint "person_id"
    t.string "function", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_affiliations_on_institution_id"
    t.index ["person_id"], name: "index_affiliations_on_person_id"
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties_jsonb_path_ops", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "blogs", force: :cascade do |t|
    t.date "planned_date"
    t.string "language", default: "de"
    t.string "working_title", default: ""
    t.text "description", default: ""
    t.string "submitted", default: "false"
    t.string "published", default: "false"
    t.string "author_informed", default: "false"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "submission_deadline"
    t.integer "assigned_to_user_id"
    t.index ["person_id"], name: "index_blogs_on_person_id"
  end

  create_table "group_people", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_people_on_group_id"
    t.index ["person_id"], name: "index_group_people_on_person_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", default: ""
    t.text "description", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name", default: ""
    t.text "description", default: ""
    t.string "email", default: ""
    t.string "language", default: ""
    t.integer "philosophie_society_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "website", default: ""
    t.string "phone"
    t.string "firstname_of_official", default: ""
    t.string "lastname_of_official", default: ""
    t.string "anrede_of_official", default: ""
  end

  create_table "language_blogs", force: :cascade do |t|
    t.bigint "blog_id"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_language_blogs_on_blog_id"
    t.index ["language_id"], name: "index_language_blogs_on_language_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "language", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.text "description"
    t.string "noteable_type"
    t.bigint "noteable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["noteable_type", "noteable_id"], name: "index_notes_on_noteable_type_and_noteable_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "form_of_address", default: ""
    t.string "firstname", default: ""
    t.string "lastname", default: ""
    t.string "name", default: ""
    t.string "email", default: ""
    t.string "phone", default: ""
    t.integer "philosophie_id"
    t.string "gender", default: ""
    t.text "description", default: ""
    t.string "language", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "website", default: ""
    t.string "phone2"
  end

  create_table "project_groups", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_project_groups_on_group_id"
    t.index ["project_id"], name: "index_project_groups_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", default: ""
    t.text "description", default: ""
    t.date "start"
    t.date "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tag_lists", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", id: :integer, default: nil, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :integer, default: nil, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.text "description", default: ""
    t.datetime "deadline"
    t.integer "priority", default: 1
    t.integer "assigned_to_user_id"
    t.string "status", default: "noch nicht angefangen"
    t.decimal "time_needed"
    t.string "taskable_type"
    t.bigint "taskable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["taskable_type", "taskable_id"], name: "index_tasks_on_taskable_type_and_taskable_id"
  end

  create_table "topic_blogs", force: :cascade do |t|
    t.bigint "topic_id"
    t.bigint "blog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_topic_blogs_on_blog_id"
    t.index ["topic_id"], name: "index_topic_blogs_on_topic_id"
  end

  create_table "topic_relations", force: :cascade do |t|
    t.bigint "topic_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_topic_relations_on_person_id"
    t.index ["topic_id"], name: "index_topic_relations_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "role", default: "user"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "work_times", force: :cascade do |t|
    t.bigint "user_id"
    t.date "date"
    t.decimal "time", precision: 16, scale: 2, default: "0.0"
    t.string "task", default: ""
    t.string "area", default: ""
    t.string "project", default: ""
    t.boolean "voluntary", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_work_times_on_user_id"
  end

  create_table "working_hours", force: :cascade do |t|
    t.date "date"
    t.string "name"
    t.string "task"
    t.decimal "hours"
    t.string "area"
    t.string "project"
    t.string "category"
    t.string "extern"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
