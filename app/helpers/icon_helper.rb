# module IconHelper
#   def feature_icon_select(owner, owner_name)
#     #Find feat sections that have valid classes and filter if owner is in feat section and use the sections to populate dropdown
#     featurable_sections = FeaturableSection.all.reject{|fs| fs.valid_classes.blank?}.reject{|fs| !fs.valid_classes.split(',').include?(owner.class.to_s)}    
#     #Fallback here if no feat sections have valid classes and grab all
#     if featurable_sections.empty?
#       featurable_sections = FeaturableSection.all
#     end
#     if featurable_sections.size > 1
#       if owner.is_a?(Product) && owner.product_categories.any? && owner.product_categories.include?(ProductCategory.find_by_permalink("videos"))
#         render :partial => "/shared/feature_select_box", :locals => {:owner => owner, :owner_name => owner_name, :featurable_sections => featurable_sections}
#       else
#          render :partial => "/shared/feature_select_box", :locals => {:owner => owner, :owner_name => owner_name, :featurable_sections => featurable_sections.reject{|f| ["2", "3", "4"].include?(f.id)}}
#       end
#     else
#       if featurable_sections.is_a?(Array) 
#         featurable_sections = featurable_sections[0]
#       end
#       feature_icon(featurable_sections, owner, owner_name)
#     end
#   end
# end