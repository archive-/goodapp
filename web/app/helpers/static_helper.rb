module StaticHelper
  def scrape
    require 'nokogiri'
    require 'open-uri'
    
    url = "http://search.yahoo.com/search;_ylt=A0oGdXw9IIVPVzkAQ2xXNyoA;_ylc=X1MDMjc2NjY3OQRfcgMyBGFvA2FvBGNzcmNwdmlkA0lvV2FpRW9HZFRCY1dMNjBUbHdLTEFOV3VMM3hIVS5GSUQ0QURRSzgEZnIDdXNoLWdsb2JhbG5ld3MEZnIyA3NidG4Ebl9ncHMDMQRvcmlnaW4Dc3JwBHBxc3RyA2FuZHJvaWQgbWFya2V0IG5ld3MEcXVlcnkDYW5kcm9pZCBtYXJrZXQgbmV3cwRzYW8DMQR2dGVzdGlkA0ZFRDAxMg--?p=android%20market%20news&fr2=sb-top&fr=ush-globalnews&pqstr=android%20market%20news"
    doc = Nokogiri::HTML(open(url))

    title = doc.at_css("title").text
    #title_url = doc.at_css("title").text[:href]    
    # news_android = doc.at_css(".sc-news li:nth-child(1) .spt").text 
    # description = doc.at_css(".sc-news li:nth-child(2) .spt").text

  end  
end
