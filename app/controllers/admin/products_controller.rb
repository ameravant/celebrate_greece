class Admin::ProductsController < AdminController
  unloadable
  before_filter :find_product, :only => [ :edit, :update, :show, :destroy, :reorder ]
  before_filter :find_categories, :only => [ :edit, :new, :create ]
  add_breadcrumb "Products", nil

  def index
    @category = ProductCategory.find_by_permalink("videos")
    if params[:product_category_id]
      products = ProductCategory.find(params[:product_category_id]).products
    else
      products = Product.all
    end
    @products = products.paginate(:page => params[:page], :per_page => 25)
  end

  def new
    @product = Product.new
    @products = Product.find(:all, :conditions => ["id != ?", @product.id])
  end
  
  def show
    @images = @product.images
  end

  def edit
    @products = @product.is_video ? Product.video.active.reject! {|c| c.id == @product.id} : Product.active.reject!{|c| c.id == @product.id}
    @products ||= []
    @related_products = @product.related_products
  end
  
  def destroy
    @product.destroy
    respond_to :js
  end
  
  def reorder
    params["images"].each_with_index do |id, position|
      @product.update_attributes(:main_image_id => id) if position == 0
      Image.update(id, :position => position + 1)
    end
    render :nothing => true
  end
  
  def create
    @product = Product.new(params[:product])
    if params[:product][:is_video]
      cat = ProductCategory.find_or_create_by_name('videos').id
      @product.product_category_ids = @product.product_category_ids << cat
      @product.product_category_ids = @product.product_category_ids.uniq.flatten
    end
    if @product.save
      flash[:notice] = "#{@product.name} created."
      redirect_to admin_products_path
    else
      render :action => "new"
    end
  end
  
  def update
    if @product.update_attributes(params[:product])
      flash[:notice] = "#{@product.name} updated."
      redirect_to admin_products_path
    else
      render :action => "edit"
    end
  end
  
  private
  
  def find_product
    @product = Product.find params[:id]
  end
  
  def find_categories  
    @product_categories = ProductCategory.all
  end
  
end
