require 'rubygems'
require 'nokogiri'
require 'open-uri'

name = "fruit ninja"

url = "https://play.google.com/store/search?q=fruit+ninja&c=apps"
doc = Nokogiri::HTML(open(url))
puts doc.at_css(".search-results-item:nth-child(1) .details").text
path = doc.at_css(".title")[:href]
 
url2 = "https://play.google.com/"
url2 += path

puts url2
doc = Nokogiri::HTML(open(url2))

puts doc.at_css("title").text
puts doc.at_css(".doc-banner-title").text
puts doc.at_css("dd:nth-child(19)").text
puts doc.at_css("time").text
puts doc.at_css("dd:nth-child(9)").text
puts doc.at_css(".doc-metadata-list a").text
puts doc.at_css(".average-rating-value").text

doc.css(".doc-review").each do |item|
  title = item.at_css(".review-title").text
  review = item.at_css(".review-text").text
  puts title
  puts review
end

