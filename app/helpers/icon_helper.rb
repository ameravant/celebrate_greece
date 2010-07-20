# module IconHelper
#   # unloadable
#   # Spinner icon to use in hidden divs for AJAX feedback.
#   def spinner
#     image_tag spinner_loc, :id => "ajax_spinner", :size => "16x16", :class => "icon", :alt => "One moment..."
#   end
# 
#   # Outputs icon file with automatic confirm for Trash icons, let's you optionally
#   # specify the size of the icon.
#   def icon(filename, link=nil, alt=nil, path="#{icons_loc}/", size='16x16', color='gray', title=nil)
#     image_path = "#{icons_loc}/#{color}/#{size}/#{filename}.png"
#     image_options = { :size => size, :class => "icon", :alt => (alt ? alt : filename) }
#     if link
#       myconfirm = (filename == "Trash" ? "Are you sure you want to delete this?" : nil)
#       title = (filename == "Trash" ? "Delete" : title)
#       link_to image_tag(image_path, image_options), link, :class => "icon", :confirm => myconfirm, :title => (title ? title : filename)
#     else
#       image_tag image_path, image_options
#     end
#   end
#   
#   def css_icon(filename, path="#{icons_loc}/", size='16x16', color='gray')
#     "#{icons_loc}/#{color}/#{size}/#{filename}.png"
#   end
#   
#   def large_icon(filename, link=nil, alt=nil, path="#{icons_loc}/", size='32x32', color='gray')
#     image_path = "#{icons_loc}/#{color}/#{size}/#{filename}.png"
#     image_options = { :size => size, :class => "large-icon", :alt => (alt ? alt : filename) }
#     if link
#       myconfirm = (filename == "Trash" ? "Are you sure you want to delete this?" : nil)
#       link_to image_tag(image_path, image_options), link, :class => "icon", :confirm => myconfirm
#     else
#       image_tag image_path, image_options
#     end
#   end
#   
#   # Outputs a trash icon that uses AJAX and different status icons during the delete call
#   def trash_icon(record, link, record_name)
#     link_to_remote(
#       image_tag("#{icons_loc}/gray/16x16/Trash.png", :class => "icon", :alt => "Delete #{record_name}", :id => "#{dom_id(record)}_trash_icon"),
#       {
#         :url => link,
#         :method => :delete,
#         :loading => "$('#{dom_id(record)}_trash_icon').src = '#{spinner_loc}'",
#         :failure => "$('#{dom_id(record)}_trash_icon').src = '#{exclamation_loc}'",
#         :success => "$('#{dom_id(record)}_trash_icon').src = '#{ok_loc}'",
#         # :confirm => false,#"Really delete #{record_name}? There is no undo!",
#         :delay => 1
#       }, :class => "icon")
#   end
#   
#   def confirm_icon(record, link, record_name)
#     link_to_remote(
#       image_tag("#{icons_loc}/gray/16x16/Key.png", :class => "icon", :alt => "Confirm #{record_name}", :id => "#{dom_id(record)}_key_icon"),
#       {
#         :url => link,
#         :method => :put,
#         :loading => "$('#{dom_id(record)}_key_icon').src = '#{spinner_loc}'",
#         :failure => "$('#{dom_id(record)}_key_icon').src = '#{exclamation_loc}'",
#         :success => "$('#{dom_id(record)}_key_icon').src = '#{ok_loc}'",
#         :delay => 1
#       }, :class => "icon")
#   end
#   
#   def navigation_icon(record, record_name, display)
#     link_to(
#       image_tag("#{icons_loc}/green/16x16/Link.png", :class => "icon", :title => "Remove #{record_name} from menu navigation.", :alt => "Remove #{record_name} from menu navigation.", :id => "#{dom_id(record)}_navigate_icon", :style => "display: #{display};"),
#       admin_product_category_menu_path(record, record.menus.first), :class => "icon")
#   end
#   
#   def activate_navigation_icon(record, link, record_name, display)
#     link_to(
#       image_tag("#{icons_loc}/red/16x16/Link.png", :class => "icon", :title => "Add #{record_name} to menu navigation.", :alt => "Add #{record_name} to menu navigation.", :id => "#{dom_id(record)}_navigate_icon", :style => "display: #{display};"), link, :class => "icon")
#   end
#   
#   # The next three icons include all featurable icon functionality
#   def defeature_icon(featurable_sections, owner, owner_name)
#     # link_to_remote(
#     #   image_tag("#{icons_loc}/green/16x16/Star.png", :class => "icon", :title => "Defeature #{owner_name}", :alt => "Defeature #{owner_name}", :id => "#{dom_id(owner)}_defeature_icon", :style => "display: #{display};"),
#     #   {:url => admin_featurable_section_features_path(
#     #    featurable_sections.first.id, 
#     #    :params => {:owner_id => owner.id, :owner_class => owner.class}), 
#     #    :method => :delete, 
#     #    :failure => "$('#{dom_id(owner)}_defeature_icon').src = '#{exclamation_loc}'", 
#     #    :loading => "$('#{dom_id(owner)}_defeature_icon').src = '#{spinner_loc}'", 
#     #    :success => "$('#{dom_id(owner)}_defeature_icon').src = '#{icons_loc}/gre/16x16/Star.png'; $('#{dom_id(owner)}_defeature_icon').hide(); $('#{dom_id(owner)}_feature_icon').show()",
#     #    :delay => 1}, 
#     #    :class => "icon")
#   end
#   
#   def feature_icon_select(owner, owner_name)
#     #Find feat sections that have valid classes and filter if owner is in feat section and use the sections to populate dropdown
#     featurable_sections = FeaturableSection.all.reject{|fs| fs.valid_classes.blank?}.reject{|fs| !fs.valid_classes.split(',').include?(owner.class.to_s)}    
#     #Fallback here if no feat sections have valid classes and grab all
#     if featurable_sections.empty?
#       featurable_sections = FeaturableSection.all
#     end
#     if  featurable_sections.size > 1 && owner.respond_to?(:features_count)
#       render :partial => "/shared/feature_select_box", :locals => {:owner => owner, :owner_name => owner_name, :featurable_sections => featurable_sections}
#     else 
#       if featurable_sections.class == Array 
#         featurable_sections = featurable_sections[0]
#       end
#       feature_icon(featurable_sections, owner, owner_name)
#     end
#   end  
#   
#   def feature_icon(featurable_sections, owner, owner_name)
# 
# #This is if the owner is featured
#     if featurable_sections.features and featurable_sections.features.select{|f| f.featurable_type == "#{owner.class}" and f.featurable_id == owner.id}.length > 0
#       tmpfeature = featurable_sections.features.select{|f| f.featurable_type == "#{owner.class}" and f.featurable_id == owner.id}
#       "#{link_to_remote(
#         image_tag("#{icons_loc}/green/16x16/Star.png", :class => "icon", :title => "Defeature #{owner_name}", :alt => "Defeature #{owner_name}", :id => "#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon", :style => "display: inline"),
#         {:url => admin_feature_path(1, :params => {:owner_id => owner.id, :owner_class => owner.class, :featurable_section => featurable_sections}), 
#          :method => "delete", 
#          :failure => "$('#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon').src = '#{exclamation_loc}'", 
#          :loading => "$('#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon').src = '#{spinner_loc}'", 
#          :success => "$('#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon').src = '#{icons_loc}/green/16x16/Star.png'; $('#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon').hide(); $('#{dom_id(owner)}_#{featurable_sections.id}_feature_icon').show()",
#          :delay => 1}, 
#          :class => "icon")}
#        #{link_to_remote(
#          image_tag("#{icons_loc}/red/16x16/Star.png", :class => "icon", :title => "Feature #{owner_name} on homepage", :alt => "Feature #{owner_name} on homepage", :id => "#{dom_id(owner)}_#{featurable_sections.id}_feature_icon", :style => "display: none"),
#          {:url => admin_featurable_section_features_path(
#           featurable_sections.id, 
#           :params => {:owner_id => owner.id, :owner_class => owner.class}), 
#           :method => :create, 
#           :failure => "$('#{dom_id(owner)}_#{featurable_sections.id}_feature_icon').src = '#{exclamation_loc}'", 
#           :loading => "$('#{dom_id(owner)}_#{featurable_sections.id}_feature_icon').src = '#{spinner_loc}'", 
#           :success => "$('#{dom_id(owner)}_#{featurable_sections.id}_feature_icon').src = '#{icons_loc}/red/16x16/Star.png'; $('#{dom_id(owner)}_#{featurable_sections.id}_feature_icon').hide(); $('#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon').show()",
#           :delay => 1}, 
#           :class => "icon")}"
#     else
# #This is if the owner is not featured
#       if featurable_sections.image_required and owner.images.blank?
#         link_to(image_tag("#{icons_loc}/gray/16x16/Star.png", :class => "icon", :title => "#{owner_name} must have images to be featured on the homepage.", :alt => "#{owner_name} must have images to be featured on the homepage.", :id => "#{dom_id(owner)}_#{featurable_sections.id}_feature_icon"), [:new, :admin, owner, :image], :class => "icon")
#       else
#       "#{link_to_remote(
#         image_tag("#{icons_loc}/red/16x16/Star.png", :class => "icon", :title => "Feature #{owner_name} on homepage", :alt => "Feature #{owner_name} on homepage", :id => "#{dom_id(owner)}_#{featurable_sections.id}_feature_icon", :style => "display: inline;"),
#         {:url => admin_featurable_section_features_path(
#          featurable_sections.id, 
#          :params => {:owner_id => owner.id, :owner_class => owner.class}), 
#          :method => :create, 
#          :failure => "$('#{dom_id(owner)}_#{featurable_sections.id}_feature_icon').src = '#{exclamation_loc}'", 
#          :loading => "$('#{dom_id(owner)}_#{featurable_sections.id}_feature_icon').src = '#{spinner_loc}'", 
#          :success => "$('#{dom_id(owner)}_#{featurable_sections.id}_feature_icon').src = '#{icons_loc}/red/16x16/Star.png'; $('#{dom_id(owner)}_#{featurable_sections.id}_feature_icon').hide(); $('#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon').show(); $('#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon').show()",
#          :delay => 1}, 
#          :class => "icon")}
#       #{link_to_remote(
#          image_tag("#{icons_loc}/green/16x16/Star.png", :class => "icon", :title => "Defeature #{owner_name}", :alt => "Defeature #{owner_name}", :id => "#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon", :style => "display: none;"),
#          {:url => admin_feature_path(1, :params => {:owner_id => owner.id, :owner_class => owner.class, :featurable_section => featurable_sections}), 
#           :method => "delete", 
#           :failure => "$('#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon').src = '#{exclamation_loc}'", 
#           :loading => "$('#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon').src = '#{spinner_loc}'", 
#           :success => "$('#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon').src = '#{icons_loc}/green/16x16/Star.png'; $('#{dom_id(owner)}_#{featurable_sections.id}_defeature_icon').hide(); $('#{dom_id(owner)}_#{featurable_sections.id}_feature_icon').show()",
#           :delay => 1}, 
#           :class => "icon")}"
#       end
#     end
#   end
#   
#   def disabled_feature_icon(record, link, record_name)
#     record.class
#     # if @cms_config['features']['feature_box']
#     #   link_to(image_tag("#{icons_loc}/gray/16x16/Star.png", :class => "icon", :title => "#{record_name} must have images to be featured on the homepage.", :alt => "#{record_name} must have images to be featured on the homepage.", :id => "#{dom_id(record)}_feature_icon"), link, :class => "icon")
#     # else
#     #   ""
#     # end
#   end
#   
#   def icon_with_text(filename, currobject, imagepath='/plugin_assets/siteninja_core/images/icons/gray/16x16', size='16x16')
#     image_path = "#{imagepath}/#{filename}.png"
#     image_options = { :size => size, :class => "icon", :id => "#{currobject.id}_delete_icon" }
#     ajax_url = [:admin, currobject]
#     confirm_text = "Really delete this?"
#     case filename
#       when "Trash":
#         link_to_remote(image_tag(image_path, image_options), :url => ajax_url, :method => :delete, :confirm => confirm_text) + "&nbsp;" + link_to_remote("Delete", :url => ajax_url, :method => :delete, :loading => "$('#{currobject.id}_delete_icon').src = '#{spinner_loc}'", :confirm => confirm_text)
#     end
#   end
# 
#   # Outputs asset icon file based on filename extention.
#   def asset_file_type_icon(filename, link_url)
#     ext = case filename.match(/\.\w+/).to_s
#       when /(aac|bmp|diz|log|mpv2|rar|ttf|wzv|ac3|bup|dll|hlp|m4a|msi|rb|txt|xls|ace|cab|doc|m4p|music|reg|uis|xlsx|ade|cat|docx|ie7|mmf|nfo|rtf|upload|xml|adp|chm|dos|ifo|mmm|one|safari|url|xsl|ai|cmd|download|inf|mov|pdd|scp|vcr|zap|aiff|css|dvd|ini|movie|pdf|search|video|zip|aspx|csv|dwg|iso|mp2|php|sql|vob|au|cue|dwt|isp|mp2v|png|swf|wba|avi|dat|emf|java|pps|sys|wma|bak|default|exc|jfif|mp4|ppt|theme|wmv|bat|der|fav|mpe|pptx|tif|wpl|bin|dic|print|tiff|wri|blue-ray|divx|font|js|psd|tmp|wtx)/: $1
#       when /(gif|png|jpeg|jpg)/: "jpeg"
#       when /(mpg|mpeg)/: "mpeg"
#       when /fla/: "flash"
#       when /htm/: "html"
#       when /doc/: "word"
#       when /flv/: "video"
#       when /pdf/: "pdf"
#       when /(mp3|audio)/: "ac3"
#       else "default"
#     end
#     link_to image_tag("#{icons_loc}/file_types/#{ext}.png", :width => 48, :alt => ext.upcase), link_url, :class => "lightview", :rel => "set[assets]"
#   end
#   def unpaid_icon(record, link, record_name, display)
#     link_to_remote(
#       image_tag("#{icons_loc}/red/16x16/Currency Dollar.png", :class => "icon", :title => "Mark paid for #{record_name} on homepage", :alt => "Currently unpaid for #{record_name}", :id => "#{dom_id(record)}_unpaid_icon", :style => "display: #{display};"),
#       {
#         :url => link,
#         :with => "'paid=true'",
#         :method => :put, 
#         :failure => "$('#{dom_id(record)}_unpaid_icon').src = '#{exclamation_loc}'",
#         :loading => "$('#{dom_id(record)}_unpaid_icon').src = '#{spinner_loc}'",
#         :success => "$('#{dom_id(record)}_unpaid_icon').src = '#{icons_loc}/green/16x16/Currency Dollar.png'; ",
#         :delay => 1
#       }, :class => "icon")
#   end
#   def paid_icon(record, link, record_name, display)
#     link_to_remote(
#       image_tag("#{icons_loc}/green/16x16/Currency Dollar.png", :class => "icon", :title => "Mark unpaid #{record_name} on homepage", :alt => "Currently paid for #{record_name}", :id => "#{dom_id(record)}_paid_icon", :style => "display: #{display};"),
#       {
#         :url => link,
#         :with => "'paid=false'",
#         :method => :put, 
#         :failure => "$('#{dom_id(record)}_paid_icon').src = '#{exclamation_loc}'",
#         :loading => "$('#{dom_id(record)}_paid_icon').src = '#{spinner_loc}'",
#         :success => "$('#{dom_id(record)}_paid_icon').src = '#{icons_loc}/red/16x16/Currency Dollar.png';" ,
#         :delay => 1
#       }, :class => "icon")
#     
#   end
# 
# end
