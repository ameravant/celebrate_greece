xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title(@cms_config['website']['name'])
    # xml.description("")
    xml.language('en-us')

    for product in @all_products
      xml.item do
        xml.title(h(product.name))
        xml.description(h(product.blurb))
        xml.guid(product_url(product))
        if product.is_video?
          xml.video_length(product.video_length) if product.video_length
          xml.price(product.price)
          xml.upc(product.upc)
        end
      end
    end
  }
}
