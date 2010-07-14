class Product < ActiveRecord::Base
  require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_store/app/models/product.rb"
  acts_as_taggable
  named_scope :video, :conditions => ["is_video = ?", 't']
  named_scope :active, :conditions => ["active = ?", 't']
end