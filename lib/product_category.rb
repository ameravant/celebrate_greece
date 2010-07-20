class ProductCategory < ActiveRecord::Base
  require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_store/app/models/product_category.rb"
  has_many :menus, :as => :navigatable, :dependent => :destroy
  has_many :features, :as => :featurable, :dependent => :destroy
  has_many :images, :as => :viewable, :dependent => :destroy
  validates_uniqueness_of :name, :case_sensitive => false
  named_scope :only_public, :conditions => "private != 't'"
  def self.videos
    find_by_name("videos")
  end
end