class Product < ActiveRecord::Base
  named_scope :video, :conditions => ["is_video = ?", 't']
  named_scope :active, :conditions => ["active = ?", 't']
  require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_store/app/models/product.rb"
  def self.videos_tagged_with(tag)
    active.video.find_tagged_with(tag)
  end
  def price
    self.product_options.any? ? self.product_options[0].price : nil
  end
end