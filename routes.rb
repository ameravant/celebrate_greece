namespace :admin do |admin|
  admin.resources :product_categories, :collection => { :reorder => :put }, :member => { :reorder => :put } do |cat|
    cat.resources :products
  end
end