class RemoveColumnsFromProduct < ActiveRecord::Migration[8.0]
  def change
    remove_column :products, :gender
    remove_column :products, :purpose
    remove_column :products, :material
    remove_column :products, :features
    remove_column :products, :color
    remove_column :products, :model_product_name
    remove_column :products, :product_type
    remove_column :products, :size_description
  end
end
