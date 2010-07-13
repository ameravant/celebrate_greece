class AddIsVideoToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :is_video, :boolean
  end

  def self.down
    remove_column :products, :is_video
  end
end
