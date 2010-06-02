class AddFieldsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :embed_code, :string
    add_column :products, :short_description, :text
    add_column :products, :featured, :boolean
    add_column :products, :active, :boolean
    add_column :products, :resolution, :string
    add_column :products, :aspect, :string
    add_column :products, :map, :float
    add_column :products, :upc, :string
    add_column :products, :producer, :string
    add_column :products, :vod, :string
    add_column :products, :language, :string
    add_column :products, :video_length, :time
    add_column :products, :trailer_length, :time
    add_column :products, :subtitled, :string
    add_column :products, :country, :string
    add_column :products, :region, :string
  end

  def self.down
    remove_column :products, :region
    remove_column :products, :country
    remove_column :products, :subtitled
    remove_column :products, :trailer_length
    remove_column :products, :video_length
    remove_column :products, :language
    remove_column :products, :vod
    remove_column :products, :producer
    remove_column :products, :upc
    remove_column :products, :map
    remove_column :products, :aspect
    remove_column :products, :resolution
    remove_column :products, :active
    remove_column :products, :featured
    remove_column :products, :short_description
    remove_column :products, :embed_code
  end
end
