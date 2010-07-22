class ApiSearchesController < ApplicationController
  def create
    # vimeo info
    # Consumer Key: c3fd124f2ac903553dfd1df3bd62a681 
    # Consumer Secret: 7e32b1f74210ee86 Please do not share this with others
    # gem install httpclient oauth-client oauth httparty json
    if params[:api_searches][:vimeo_search]
      redirect_to api_searches_url(:vimeo_search => params[:api_searches][:vimeo_search])
    else
      p = ProductCategory.find_by_name("Stock Footage")
      redirect_back_or_default("/product_categories/#{p.id}-#{p.permalink}")
    end
  end
  def index
    url = "http://vimeo.com/api/rest?api_key=c3fd124f2ac903553dfd1df3bd62a681&method=vimeo.videos.search&query=#{params[:vimeo_search]}&api_sig=724a210d5e4cacd2eb672b8333b2ec71&full_response=true&per_page=12"
    @response = Hpricot open(url)
  end
  
end
