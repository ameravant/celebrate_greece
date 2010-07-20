class AddImagesCountAndFeaturesCountToProductCategories < ActiveRecord::Migration
  def self.up
    add_column :product_categories, :images_count, :integer, :default => 0
    add_column :product_categories, :features_count, :integer, :default => 0
  end

  def self.down
    remove_column :product_categories, :features_count
    remove_column :product_categories, :images_count
  end
end
