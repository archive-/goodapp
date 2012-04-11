require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://www.windowsphone.com/en-US/apps/49c69a08-60fe-df11-9264-00237de2db9e"
doc = Nokogiri::HTML(open(url))

puts doc.at_css("title").text
puts doc.at_css("h1").text
puts doc.at_css("#licenseOptions").text
puts doc.at_css("#publisher a").text
puts doc.at_css("#version li").text
puts doc.at_css("#rating span").text
puts doc.at_css("#disclosures li").text
puts doc.at_css("#buy").text

doc.css("#reviews li").each do |item|
  author = item.at_css(".author").text
  review = item.at_css("p").text
  puts author
  puts review
end