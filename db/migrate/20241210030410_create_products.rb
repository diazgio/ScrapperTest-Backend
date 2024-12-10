class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title, null: false, default: ""
      t.text :description, null: false, default: ""
      t.string :size_tag, null: false, default: ""
      t.string :size_description, null: false, default: ""
      t.string :discounted_price, null: false, default: ""
      t.string :normal_price, null: false, default: ""
      t.string :discount, null: false, default: ""
      t.string :raitings_reviews, null: false, default: ""
      t.float :raitings_average, null: false, default: 0.0
      t.string :gender
      t.string :purpose
      t.string :material
      t.string :features
      t.string :color
      t.string :model_product_name
      t.string :product_type
      t.string :image_links, null: false, array: true, default: []

      t.timestamps
    end
  end
end
