class Product < ActiveRecord::Base
  require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_store/app/models/product.rb"
  acts_as_taggable
  attr_accessor :is_video
end