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

ActiveRecord::Schema[8.0].define(version: 2024_12_10_030410) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "products", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "description", default: "", null: false
    t.string "size_tag", default: "", null: false
    t.string "size_description", default: "", null: false
    t.string "discounted_price", default: "", null: false
    t.string "normal_price", default: "", null: false
    t.string "discount", default: "", null: false
    t.string "raitings_reviews", default: "", null: false
    t.float "raitings_average", default: 0.0, null: false
    t.string "gender"
    t.string "purpose"
    t.string "material"
    t.string "features"
    t.string "color"
    t.string "model_product_name"
    t.string "product_type"
    t.string "image_links", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
