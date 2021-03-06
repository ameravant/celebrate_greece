class PagesController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  
  def show
    begin
      @page = Page.find_by_permalink! params[:id]
      @menu = @page.menus.first
      @side_column_sections = ColumnSection.all(:conditions => {:column => "side", :visible => true})
      @images = @page.images
      @footer_pages = Page.find(:all, :conditions => {:show_in_footer => true}, :order => :footer_pos )
      @features = []
      @menu.featurable_sections.each do |fs|
        @features += fs.features
      end
      if @menu.is_homepage?
        @sections = @menu.featurable_sections.without_default_sections
      end
      feature_sections = FeaturableSection.all.reject{|fs| !fs.site_wide}
      if feature_sections
        feature_sections.each do |fs|
          @features += fs.features
        end
      end
      # if @page.permalink == "home"
      #   @features = Feature.find(:all, :order => :position)
      # end
      #should refactor the following into scopes and add scoping by scoping
      ops = "person_id = #{@page.author_id}" if @page.author_id
      articles = @page.article_category_id.nil? ? Article.published.find(:all, :conditions => ops) : @page.article_category.articles.published.find(:all, :conditions => ops)
      @testimonial = Testimonial.featured.sort_by(&:rand).first
      @article_categories = ArticleCategory.active
      @article_archive = articles.group_by { |a| [a.published_at.month, a.published_at.year] }
      @article_authors = Person.active.find(:all, :conditions => "articles_count > 0")
      @article_tags = Article.published.tag_counts.sort_by(&:name)
      @recent_articles = articles
      if @page.show_events? and @cms_config['modules']['events']
        @events = Event.future[0..2]
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to '/404.html'
    end
    @menus_tmp = []
      build_tree(@menu)
      add_breadcrumb "Home", "/" unless @page.permalink == "home" or @menu.parent_id == 1
      for menu in @menus_tmp.reverse
        unless menu == @menu
          if menu.navigatable_type == "Page"
            add_breadcrumb menu.navigatable.title, "/#{menu.navigatable.permalink}"
          else
            add_breadcrumb menu.navigatable.title, menu.navigatable
          end
        else  
          add_breadcrumb @menu.navigatable.title unless @page.permalink == "home" 
        end
      end
      session[:redirect] = request.request_uri if @members
      authorize("Member", "Members") if @members
  end

private

 def build_tree(current_menu)
  @menus_tmp << current_menu
  @members = true if current_menu.navigatable.permalink == "members"
  if current_menu.parent_id
    parent_menu = Menu.find(current_menu.parent_id)
    build_tree(parent_menu)
  end  
end



end
