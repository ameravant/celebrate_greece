class ProductCategoriesController < ApplicationController
  unloadable
  add_breadcrumb 'Home', 'root_path'
  add_breadcrumb 'Products', 'products_path'
  before_filter :find_page
  
  def show
    #vimeo info
    # Consumer Key: c3fd124f2ac903553dfd1df3bd62a681 
    # Consumer Secret: 7e32b1f74210ee86 Please do not share this with others
    begin
      @productcategories = ProductCategory.only_public
      @topproductcategories = ProductCategory.all(:conditions => {:parent_id => nil, :private => false})
      @productcategory = ProductCategory.find(params[:id])
      @products = @productcategory.products
      @product_category_tmp = []
      build_tree(@productcategory)
      for product_category in @product_category_tmp.reverse
        unless product_category == @productcategory
          add_breadcrumb product_category.title, product_category_path(product_category)
        else  
          add_breadcrumb product_category.title
        end
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to '/404.html'
    end
    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml { render :xml => @products.to_xml }
      wants.rss { render :layout => false } # uses index.rss.builder
    end
  end

  private
  
  def find_page
    @footer_pages = Page.find(:all, :conditions => {:show_in_footer => true}, :order => :footer_pos )
    @page = Page.find_by_permalink!('products')
    @productcategories = ProductCategory.all(:conditions => {:parent_id => nil, :private => false})
  end
  
  def build_tree(current_product_category)
    @product_category_tmp << current_product_category
    unless current_product_category.parent_id == nil
      parent_product_category = ProductCategory.find_by_id(current_product_category.parent_id)
      build_tree(parent_product_category)
    end
  end
end
