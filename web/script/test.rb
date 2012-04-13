require 'rubygems'
require 'nokogiri'
require 'open-uri'

    url_wired = "http://www.wired.com/gadgetlab/tag/android-market/"
    doc = Nokogiri::HTML(open(url_wired))
    doc.css(".tag-android-market").each_with_index do |item, i|
      puts item.at_css("h2 a").text
      puts item.at_css("h2 a")[:href]      
    end
