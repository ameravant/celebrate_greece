namespace :db do
  desc "Populate database with sweet, sweet dummy data."
  task :populate_greece => :environment do
    require "#{RAILS_ROOT}/vendor/plugins/siteninja/celebrate_greece/lib/product_category.rb"
    require "#{RAILS_ROOT}/vendor/plugins/siteninja/celebrate_greece/lib/product.rb"
    
     ###################################################################
#
# description:   database populator task for development use
# dependencies:  Populator and Faker gems (use `sudo gem install`)
# usage:         `rake db:populate` from your application's root
#
###################################################################

    @cms_config = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    require 'populator'
    require 'faker'

    if Rails.env.production?
      $DOMAIN_PATH = "http://#{@cms_config['website']['domain']}"
    else
      $DOMAIN_PATH = "http://localhost:3000"
    end

    def fake_events
      puts 'Faking events...'
      Event.populate 4 do |e|
        e.name = Populator.words(2..5)
        e.address = "#{rand(1400)+100} State St, Santa Barbara, CA"
        e.description = generate_random_body_content
        e.event_date_and_time = 1.month.ago..3.months.from_now
        e.user_id = $USERS.rand.id
        if rand(2) == 0
          e.registration = true
          e.allow_cash = [true, false]
          e.allow_card = [true, false]
          e.allow_check = [true, false]
          e.check_instructions = Populator.paragraphs(1) if e.allow_check
          if rand(2) == 0
            e.registration_limit = [10, 50, 100, 200, 500]
            e.registration_closed_text = Populator.paragraphs(1)
          end
        end
      end

      puts 'Making permalinks...'
      Event.all.each { |event| event.update_attribute(:permalink, make_permalink(event.name)) }
    end
    
    def add_pages
      puts "Creating pages..."

      home = Page.create(:title => 'Home', :body => 'home',
        :meta_title => "Home", :permalink => "home", :can_delete => false, :position => 1)
        Page.create(:title => 'About Us', :body => 'About', :meta_title => "About #{@cms_config['website']['name']}")
        Page.create(:title => 'Blog', :meta_title => 'Blog', :body => "blog", :permalink => "blog", :can_delete => false, :column_id => 2, :show_article_cats => true) if @cms_config['modules']['blog']
        Page.create(:title => 'Images', :meta_title => 'Galleries', :body => "galleries", :permalink => "galleries", :can_delete => false) if @cms_config['modules']['galleries']
        Page.create(:title => 'Products', :meta_title => 'Products', :body => "Products", :permalink => "products", :can_delete => false) if @cms_config['modules']['product']
        contact = Page.create( :title => 'Contact Us', :body => "<h1>Contact #{@cms_config['website']['name']}</h1>", :meta_title => "Contact #{@cms_config['website']['name']}", :permalink => "inquire")
        Page.create(:title => 'Members', :meta_title => 'members', :body => "members", :permalink => "members", :can_delete => true) if @cms_config['modules']['members']
        Page.create(:title => 'Profiles', :meta_title => 'profiles', :body => "profiles", :permalink => "profiles", :can_delete => true) if @cms_config['modules']['profiles']
        Page.create(:title => 'Links', :meta_title => 'Links', :body => "links", :permalink => "links", :can_delete => false) if @cms_config['modules']['links']
        Page.create(:title => 'Testimonials', :body => 'Testimonials', :meta_title => 'Testimonials', :show_in_footer => true, :can_delete => false, :parent_id => home.id) if @cms_config['features']['testimonials']
        Page.create(:parent_id => contact.id, :title => 'Contact Us - Thank You', :body => 'Thank you for your inquiry. We usually respond within 24 hours.', :meta_title => "Message sent", :permalink => "inquiry_received", :status => 'hidden', :show_in_footer => false)
        Page.create(:parent_id => contact.id, :title => 'Privacy Policy',:show_articles => false,:show_events => false, :show_in_footer => true, :show_in_menu => false, :body => 'This page can be helpful when creating a privacy policy <a href="http://www.freeprivacypolicy.com/privacy.php">http://www.freeprivacypolicy.com/privacy.php</a>', :meta_title => "Privacy Policy")
        Page.create(:parent_id => contact.id, :title => 'Terms of Use', :show_articles => false,:show_events => false, :show_in_footer => true, :show_in_menu => false, :body => 'Terms of Use', :status => 'hidden', :meta_title => "Terms of Use")
        for page in Page.all
          if page.menus.empty?
            menu = page.menus.new
            menu.save
          end
        end
        for menu in Menu.all
          page = menu.navigatable
          unless page.parent_id.blank?
            parent_page = Page.find(page.parent_id)
            menu.parent_id = parent_page.menus.first.id
          end
          menu.position = page.position
          menu.footer_pos = page.footer_pos
          menu.show_in_footer = page.show_in_footer
          menu.can_delete = page.can_delete
          menu.status = page.status
          menu.save
        end
      end

    puts 'Adding role groups...'

    admin = PersonGroup.create(:title => "Admin", :role => true, :public => false, :description => "Has access to all areas of the CMS.")
    author = PersonGroup.create(:title => "Author", :role => true, :public => false, :description => "Can write and publish their own articles.")
    editor = PersonGroup.create(:title => "Editor", :role => true, :public => false, :description => "Can write, edit, and publish any article, and moderates comments.")
    contributor = PersonGroup.create(:title => "Contributor", :role => true, :public => false, :description => "Can write their own articles, but cannot publish them.")
    moderator = PersonGroup.create(:title => "Moderator", :role => true, :public => false, :description => "Can moderate comments.")
    member = PersonGroup.create(:title => "Member", :role => true, :public => false, :description => "Has access to member areas.") if @cms_config['modules']['members']
    newsletter = PersonGroup.create(:title => "Newsletter", :role => false, :public => true, :description => "Subscribe to the newsletter.") if @cms_config['modules']['newsletters']

    puts 'Adding users...'

    # Create the default administrator. REMEMBER: Have the client change this username/password
    person = Person.create(:first_name => "admin", :last_name => "admin", :email => "admin@mailinator.com", :zip => "93101", :country => "USA")
    person.person_groups << admin
    user = User.create(:login => 'admin', :password => 'admin', :password_confirmation => 'admin', :active => true)
    user.person_id = person.id
    user.save

    # Create the Ameravant logins
    michael = Person.create(:first_name => "Michael", :last_name => "Kramer", :email => "michael@ameravant.com", :zip => "93101", :country => "USA")
    michael.person_groups << admin
    user = User.create(:login => "michael", :password => "123Mail", :password_confirmation => "123Mail", :active => true)
    user.person_id = michael.id
    user.save
    dave = Person.create(:first_name => "Dave", :last_name => "Myers", :email => "dave@ameravant.com", :zip => "93101", :country => "USA")
    dave.person_groups << admin
    user = User.create(:login => "dave", :password => "123Mail", :password_confirmation => "123Mail", :active => true)
    user.person_id = dave.id
    user.save
    
     Setting.create(
       :newsletter_from_email => 'admin@ameravant.com',
       :footer_text => "<p>&copy; #YEAR# #{@cms_config['website']['name']}</p>",
       :inquiry_notification_email => "contact@#{@cms_config['website']['domain']}",
       :inquiry_confirmation_subject_line => "Inquiry",
       :inquiry_confirmation_message => "Thank you for your Inquiry. We usually respond to inquiries within 24 hours.",
       :comment_profanity_filter => true,
       :events_range => 3,
       :tracking_code => '<script type="text/javascript">
 var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
 document.write(unescape("%3Cscript src=\'" + gaJsHost + "google-analytics.com/ga.js\' type=\'text/javascript\'%3E%3C/script%3E"));
 </script>
 <script type="text/javascript">
 try {
 var pageTracker = _gat._getTracker("UA-7311013-1");
 pageTracker._trackPageview();
 } catch(err) {}</script>'
     )
    
    add_pages
# This adds Featurable Section backend needed for a new site to have a homepage feature box
    fs = FeaturableSection.first
    m = Menu.first
    if m and fs
      m.featurable_sections << fs
      m.save
    end

    
    
    def create_featurable_sections
      puts "creating featurable sections ...."
      m = Menu.first
      for title in ["Most Popular Videos", "New Videos", "Trailers" ]
        fs = FeaturableSection.create(:title => title, :image_required => true, :site_wide => "false")
        m.featurable_sections << fs
      end
    end
    def create_product_categories
      "creating product categories ...."
      pc = ProductCategory.create(:name => "Videos")
      ProductCategory.create(:name => "MAP", :parent_id => pc.id)
    end
    create_featurable_sections
    create_product_categories
    Plugin.create(:url => "git@github.com:ameravant/celebrate_greece.git", :position => 11)
    Plugin.create(:url => "git@github.com:ameravant/celebrate_greece_pages.git", :position => 13)
    Plugin.find_by_url("git@github.com:ameravant/siteninja_pages.git").update_attributes(:position => 12)
    
  end
end