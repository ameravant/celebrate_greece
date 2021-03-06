class ProductsController < ApplicationController
  unloadable

	before_filter :find_page

  def index
    if params[:video_search].blank?
      if !params[:tag].blank?
        # Filter articles by tag
        @products = params[:product_category_id] == ProductCategory.videos.id ? Product.videos_tagged_with(params[:tag]) : Product.active.find_tagged_with(params[:tag])
      elsif params[:product_category_id]
        @products = ProductCategory.find(params[:product_category_id]).parent.name == "videos" ? ProductCategory.find(params[:product_category_id]).products.active.video : ProductCategory.find(params[:product_category_id]).products.active
      else
        @products = Product.active.featured
        @all_products = Product.all
        @heading = "Product"
      end
      @map = false
      if request.request_uri =~ /^\/map$/
        @videos = Product.video.active
        @map = true
      end
    else
      videos = []
      for parameter in params[:video_search].to_s.split
        videos << Product.title_or_description_like(parameter)
      end
      products = videos.flatten.reject{|v| !v.is_video?}
      @products = products.paginate(:page => params[:page], :per_page => 25)
    end
   respond_to do |wants|
     wants.html # index.html.erb
     wants.xml { render :xml => @products.to_xml }
     wants.rss { render :layout => false } # uses index.rss.builder
   end
  end

  def show
    begin
      @menu_selected = "products"
      @product = Product.find params[:id], :conditions => { :active => true, :deleted => false }
      @category = ProductCategory.find_or_create_by_name("Wholesale")
      @heading = @product.name
      @testimonial = Testimonial.find(:all, :conditions => ["quotable_id = ?" , @product.id]).sort_by(&:rand).first #Select a random testimonial
      if @product.product_categories.any?
        @productcategory = @product.product_categories.first
        @product_category_tmp = []
        build_tree(@productcategory)
        for product_category in @product_category_tmp.reverse
          add_breadcrumb product_category.title, product_category_path(product_category)
        end
			end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "The product you were looking for was not found."
      redirect_to products_path
    end
  end

  def add_to_cart
    begin
      @product = Product.find params[:id], :conditions => { :active => true, :deleted => false }
      find_cart.add_product(@product, 1)
      redirect_to cart_path
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "That product is not available."
      redirect_to products_path
    end
  end

  private

  def find_page
    @footer_pages = Page.find(:all, :conditions => {:show_in_footer => true}, :order => :footer_pos )
    @page = Page.find_by_permalink!('products')
    @productcategories = ProductCategory.only_public
    @topproductcategories = ProductCategory.only_public(:conditions => {:parent_id => nil})
    # @product_category_tmp = []
    #     build_tree(@product_category)
    #     for product_category in @product_category_tmp.reverse
    #       unless product_category == @product_category
    #         add_breadcrumb product_category.title, product_category_path(product_category)
    #       else  
    #         add_breadcrumb product_category.title
    #       end
    #     end
  end

  def find_cart
    session[:cart] ||= Cart.new
  end

  def build_tree(current_product_category)
    @product_category_tmp << current_product_category
    unless current_product_category.parent_id == nil
      parent_product_category = ProductCategory.find_by_id(current_product_category.parent_id)
      build_tree(parent_product_category)
    end
  end

end

