class AddMenusToProductCategories < ActiveRecord::Migration
  def self.up
    add_column :product_categories, :menus_count, :integer, :default => 0
    add_column :product_categories, :private, :boolean, :default => false
  end

  def self.down
    remove_column :product_categories, :private
    remove_column :product_categories, :menus_count
  end
end
