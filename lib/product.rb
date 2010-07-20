class Product < ActiveRecord::Base
  require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_store/app/models/product.rb"
  acts_as_taggable
  named_scope :video, :conditions => ["is_video = ?", 't']
  named_scope :active, :conditions => ["active = ?", 't']
  def self.videos_tagged_with(tag)
    active.video.find_tagged_with(tag)
  end
  def price
    self.product_options.any? ? self.product_options[0].price : nil
  end
end