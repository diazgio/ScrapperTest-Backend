class AddProductDetailsToProduct < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :product_details, :jsonb, null: false, default: {}
  end
end
