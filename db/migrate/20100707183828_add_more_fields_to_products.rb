class AddMoreFieldsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :dvd, :string
    add_column :products, :pc_to_tv, :string
    add_column :products, :mobile, :string
    add_column :products, :itunes, :string
  end

  def self.down
    remove_column :products, :itunes
    remove_column :products, :mobile
    remove_column :products, :pc_to_tv
    remove_column :products, :dvd
  end
end
