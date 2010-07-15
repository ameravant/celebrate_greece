class ProductCategory < ActiveRecord::Base
  require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_store/app/models/product_category.rb"
  has_many :menus, :as => :navigatable, :dependent => :destroy
  
  def self.videos
    find_by_name("videos")
  end
end