resources :product_categories, :has_many => :images do |cat|
  cat.resources :products
end
namespace :admin do |admin|
  admin.resources :product_categories, :has_many => :images, :collection => { :reorder => :put }, :member => { :reorder => :put } do |cat|
    cat.resources :products
    cat.resources :menus
  end
end