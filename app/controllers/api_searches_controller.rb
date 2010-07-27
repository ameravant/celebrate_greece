class ApiSearchesController < ApplicationController
  require 'hpricot'
  require 'oauth'
  require 'digest/sha1'
  require 'hmac'
  require 'hmac-sha1'
  require 'base64'
  require 'cgi'
  require 'uri'
  require 'oauth_util.rb'
  require 'net/http'
  require 'open-uri'

  
  def create
    # vimeo info
    # Please do not share this with others
    # gem install httpclient oauth-client oauth httparty json
    # HMAC::SHA256.hexdigest('secret', 'payload')
    
    if params[:api_searches][:vimeo_search]
      redirect_to api_searches_url(:vimeo_search => params[:api_searches][:vimeo_search])
    else
      p = ProductCategory.find_by_name("Stock Footage")
      redirect_back_or_default("/product_categories/#{p.id}-#{p.permalink}")
    end
  end
  def index
    # consumer_key = 'c3fd124f2ac903553dfd1df3bd62a681' 
    #     consumer_secret = '7e32b1f74210ee86'
    #     nonce = generate_nonce
    #     api_sig = signature(base_str(params[:vimeo_search], consumer_key, consumer_secret, nonce), consumer_secret)
         url = "http://vimeo.com/api/rest?full_response=true&method=vimeo.videos.search&per_page=12&query=running"
    #     # url = "http://vimeo.com/api/rest?api_key=c3fd124f2ac903553dfd1df3bd62a681&full_response=true&method=vimeo.videos.search&per_page=12&query=running"
     #    url = "http://vimeo.com/api/rest?api_key=#{consumer_key}&full_response=true&method=vimeo.videos.search&per_page=12&query=running&api_sig=#{api_sig}"
    #     url = URI.parse(url)
    #     # See the url parse method in the gist you bookmarked
    #     # @response = 'curl -H \'Authorization: OAuth realm="",oauth_timestamp="1280253930",oauth_consumer_key="c3fd124f2ac903553dfd1df3bd62a681", oauth_nonce="#{nonce}", oauth_signature_method="HMAC-SHA1",oauth_version="1.0",oauth_signature="#{api_sig}"\' http://vimeo.com/oauth/request_token\''
    #     # @response = Hpricot open(url)
    #     head = {"authorization" => { "oauth_timestamp" => Time.now.to_i.to_s, 
    #                                 "oauth_consumer_key" => consumer_key, 
    #                                 "oauth_nonce" => nonce, 
    #                                 "oauth_signature_method" => "HMAC-SHA1", 
    #                                 "oauth_version" => "1.0", 
    #                                 "oauth_signature" => api_sig}
    #                                 }
    # @response = 
    #    Net::HTTP.start( url.host ) { | http |
    #        req = Net::HTTP::Get.new (url, initheader=head)
    #        response = http.request(req)
    #        print response.read_body
    #      }
    #      #Net::HTTP.get(url, head)
    #      # open(url, head)
    # end
    #   
    #   def signature(base_string, consumer_secret,token_secret='') 
    #       secret="#{escape(consumer_secret)}&#{escape(token_secret)}" 
    #       Base64.encode64(HMAC::SHA1.digest(secret,base_string)).chomp.gsub(/\n/,'') 
    #     end
    #     
    #     def base_str(query_string, consumer_key, consumer_secret, nonce)
    #       query_string = escape(query_string)
    #       "GET&http%3A%2F%2Fvimeo.com%2Fapi%2Frest%2Fv2%2F&method%3Dvimeo.videos.search%26oauth_consumer_key%3D#{consumer_key}%26oauth_nonce%3D#{nonce}%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D#{Time.now.to_i}%26oauth_version%3D1.0%26user_id%3DCelebrateGreeceDOTcom%26query%3D#{query_string}"
    #     end
    #     def generate_nonce
    #       Array.new( 5 ) { rand(256) }.pack('C*').unpack('H*').first
    #     end
    #     def escape( string )
    #       return URI.escape( string, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]") ).gsub('*', '%2A')
    #     end


    o = OauthUtil.new

    o.consumer_key = 'c3fd124f2ac903553dfd1df3bd62a681'
    o.consumer_secret = '7e32b1f74210ee86'

    parsed_url = URI.parse( url )

    @response =
    Net::HTTP.start( parsed_url.host ) { | http |
      req = Net::HTTP::Get.new "#{ parsed_url.path }?#{ o.sign(parsed_url).query_string }"
      response = http.request(req)
      print response.read_body
    }
  end
end
