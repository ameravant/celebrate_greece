class AddIsbnToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :isbn_ten, :string
    add_column :products, :isbn_thirteen, :string
  end

  def self.down
    remove_column :products, :isbn_thirteen
    remove_column :products, :isbn_ten
  end
end
