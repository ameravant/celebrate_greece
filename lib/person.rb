class Person < ActiveRecord::Base
  require "#{RAILS_ROOT}/vendor/plugins/siteninja/siteninja_core/app/models/person.rb"
  validates_presence_of :zip, :email, :country
end