module StaticHelper
  def scrape
    require 'nokogiri'
    require 'open-uri'
   
    title = Array.new
    decsr = Array.new
    link = Array.new 
    url = "http://www.wired.com/gadgetlab/tag/android-market/"
    doc = Nokogiri::HTML(open(url))
    i = 0
    doc.css(".tag-android-market").each do |item|
      title[i] = item.at_css("h2 a").text
      decsr[i] = item.at_css("p:nth-child(4)").text

      i = i+1
    end

    return title, decsr
  end  
end
