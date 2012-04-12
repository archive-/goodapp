require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://itunes.apple.com/us/app/fruit-ninja/id362949845?mt=8"
doc = Nokogiri::HTML(open(url))
puts doc.at_css("title").text
puts doc.at_css("h1").text
puts doc.at_css(".price").text
puts doc.at_css(".release-date").text
puts doc.at_css(".application li:nth-child(4)").text
puts doc.at_css(".application li:nth-child(7)").text
puts doc.at_css("#left-stack :nth-child(3) .rating-count").text


doc.css(".customer-review").each do |item|
  title = item.at_css(".customerReviewTitle").text
  review = item.at_css(".content").text
  puts title
  puts review
end

