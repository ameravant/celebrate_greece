class ChangeColumnTypeForProducts < ActiveRecord::Migration
  def self.up
    change_column :products, :video_length, :string
    change_column :products, :trailer_length, :string
  end

  def self.down
    change_column :products, :trailer_length, :datetime
    change_column :products, :video_length, :datetime
  end
end
