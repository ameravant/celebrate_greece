resources :product_categories, :has_many => :images do |cat|
  cat.resources :products
end
namespace :admin do |admin|
  admin.resources :product_categories, :has_many => :images, :collection => { :reorder => :put }, :member => { :reorder => :put } do |cat|
    cat.resources :products, :has_many => :features do |product|
      product.resources :images, :collection => { :reorder => :put, :add_multiple => :get }
      product.resources :testimonials
    end

    cat.resources :menus
  end
end
resources :api_searches#, :only => [:create, :index]
resources :products, :as => "map", :only => [:index]