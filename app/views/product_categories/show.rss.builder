xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0", "xmlns:media" => "http://search.yahoo.com/mrss/"){
  xml.channel{
    xml.title(@cms_config['website']['name'])
    # xml.description("")
    xml.language('en-us')

    for product in @products
      xml.item do
        xml.title(h(product.name))
        xml.category(h(@productcategory.name))
        xml.description(h(product.blurb))
        xml.guid(product_url(product))
        if product.is_video?
          xml.video_length(product.video_length.strftime("%H:%M:%S")) if product.video_length
          xml.price(product.price)
          xml.upc(product.upc)
          xml.link
          xml.media :title
          xml.media :description  
          xml.media :content, :type => "video/quicktime", :url => product.embed_code.gsub(/^.*embed src=/, '').gsub(/type.*$/, '').gsub(/^\"/, '').strip!
          xml.media :player
          xml.media :thumbnail
        end
      end
    end
  }
}
