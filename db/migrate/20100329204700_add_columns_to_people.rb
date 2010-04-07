class AddColumnsToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :suffix, :string
    add_column :people, :middle_name, :string
    add_column :people, :department, :string
    add_column :people, :fax, :string
    add_column :people, :web, :string
    add_column :people, :business_address1, :string
    add_column :people, :business_address2, :string
    add_column :people, :business_address3, :string
    add_column :people, :business_city, :string
    add_column :people, :business_state, :string
    add_column :people, :business_zip, :string
    add_column :people, :business_country, :string
    add_column :people, :address3, :string
    add_column :people, :email2, :string
    add_column :people, :country, :string
    add_column :people, :home_phone, :string
    add_column :people, :car_phone, :string
    add_column :people, :mobile_phone, :string
    add_column :people, :other_phone, :string
    add_column :people, :birthday, :datetime
  end

  def self.down
    remove_column :people, :suffix
    remove_column :people, :middle_name
    remove_column :people, :department
    remove_column :people, :fax
    remove_column :people, :web
    remove_column :people, :business_address1
    remove_column :people, :business_address2
    remove_column :people, :business_address3
    remove_column :people, :business_city
    remove_column :people, :business_state
    remove_column :people, :business_zip
    remove_column :people, :business_country
    remove_column :people, :address3
    remove_column :people, :email2
    remove_column :people, :country
    remove_column :people, :home_phone
    remove_column :people, :car_phone
    remove_column :people, :mobile_phone
    remove_column :people, :other_phone
    remove_column :people, :birthday
  end
end
