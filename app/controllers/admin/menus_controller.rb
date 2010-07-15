class Admin::MenusController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :authorization
  before_filter :find_owner#, :except => [ :destroy ]
  add_breadcrumb "Menus", "admin_menus_path", :only => [ :index ]
  
  def new
    if @owner.menus.empty?
      menu = @owner.menus.new.save
      flash[:notice] = "#{@owner.class} \"#{@owner.title}\" has been added to navigation."
      redirect_back_or_default("/admin/#{@owner.class.table_name}")
    end
  end
  
  def create
    if @owner.menus.empty?
      menu = @owner.menus.new.save
      flash[:notice] = "#{@owner.class} \"#{@owner.title}\" has been added to navigation."
      redirect_back_or_default("/admin/#{@owner.class.table_name}")
    end
  end
    
  def destroy
    @menu = Menu.find(params[:id])
    if @menu.can_delete
      @menu.navigatable.destroy if @menu.navigatable_type == "Page"
      @menu.destroy
      flash[:notice] = "#{@owner.class} \"#{@owner.title}\" has been removed from navigation."
      redirect_back_or_default("/admin/#{@owner.class.table_name}")
    else
      flash[:notice] = "Something went wrong, please try again."
      redirect_back_or_default("/admin/#{@owner.class.table_name}")
    end
  end

  
  def index
    @menus = Menu.all
  end
  
  def reorder
    params["menus"].each_with_index do |id, position|
      Menu.update(id, :position => position + 1)
    end
    render :nothing => true
  end
  
  private
  
  def find_owner
    if params[:article_id]
      @owner = Article.find params[:article_id]
    elsif params[:article_category_id]
      @owner = ArticleCategory.find params[:article_category_id]
    elsif params[:gallery_id]
      @owner = Gallery.find params[:gallery_id]
    elsif params[:product_id]
      @owner = Product.find params[:product_id]
    elsif params[:product_category_id]
      @owner = ProductCategory.find params[:product_category_id]
    elsif params[:event_id]
      @owner = Event.find(params[:event_id])
    elsif params[:link_id]
      @owner = Link.find(params[:link_id])
    elsif params[:page_id]
      @owner = Page.find_by_permalink params[:page_id]
    elsif params[:link_category_id]
      @owner = LinkCategory.find(params[:link_category_id])
    elsif params[:image_id]
      @owner = Image.find_by_id params[:image_id]
      @image = true
    end
  end
  
  def authorization
    authorize(@permissions['menus'], "Menus")
  end
  
end
