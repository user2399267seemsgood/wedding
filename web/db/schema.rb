# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_03_29_110322) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "gifts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "claimed"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "claimer_name"
    t.string "claimer_email"
    t.string "image_url"
    t.string "price_range"
    t.string "purchase_link"
  end

  create_table "guests", force: :cascade do |t|
    t.citext "email"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "token", null: false
    t.boolean "attending"
    t.string "diet"
    t.string "songs"
    t.string "notes"
    t.string "first_name"
    t.string "last_name"
    t.datetime "confirmed_at", precision: nil
    t.integer "allowed_plus_ones"
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "plus_ones", force: :cascade do |t|
    t.bigint "guest_id"
    t.string "diet"
    t.boolean "child"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["guest_id"], name: "index_plus_ones_on_guest_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "plus_ones", "guests"

  create_view "attendees", sql_definition: <<-SQL
      SELECT (guests.id)::text AS id,
      guests.first_name,
      guests.last_name,
      guests.email,
      guests.diet,
      guests.songs,
      guests.notes,
      NULL::boolean AS child,
      guests.updated_at
     FROM guests
    WHERE guests.attending
  UNION ALL
   SELECT ((plus_ones.guest_id || '-'::text) || plus_ones.id) AS id,
      plus_ones.first_name,
      plus_ones.last_name,
      NULL::citext AS email,
      plus_ones.diet,
      NULL::character varying AS songs,
      NULL::character varying AS notes,
      plus_ones.child,
      plus_ones.updated_at
     FROM (plus_ones
       JOIN guests ON ((plus_ones.guest_id = guests.id)))
    WHERE guests.attending;
  SQL
end
