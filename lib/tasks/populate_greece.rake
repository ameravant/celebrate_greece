namespace :db do
  desc "Populate database with sweet, sweet dummy data."
  task :populate_greece => :environment do
    require "#{RAILS_ROOT}/vendor/plugins/siteninja/celebrate_greece/lib/product_category.rb"
    require "#{RAILS_ROOT}/vendor/plugins/siteninja/celebrate_greece/lib/product.rb"
    
    system("rake db:populate_min")
    def create_featurable_sections
      puts "creating featurable sections ...."
      for title in ["Most Popular Videos", "New Videos", "Trailers" ]
        FeaturableSection.create(:title => title, :image_required => true, :site_wide => "false")
      end
    end
    def create_product_categories
      "creating product categories ...."
      pc = ProductCategory.create(:name => "Videos")
      ProductCategory.create(:name => "MAP", :parent_id => pc.id)
    end
    create_featurable_sections
    create_product_categories
  end
end