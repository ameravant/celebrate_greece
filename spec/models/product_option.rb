require "#{RAILS_ROOT}/spec/spec_helper.rb"

describe ProductOption do
  before(:each) do
    @valid_attributes = {
      :name => "Color",
      :price => 20,
      :product_id => 1,
      :active => true
    }
  end
  it "should create a new instance given valid attributes" do
    ProductOption.create!(@valid_attributes)
  end
  
end

