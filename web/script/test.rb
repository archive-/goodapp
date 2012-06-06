    require 'nokogiri' 
    require 'open-uri'
 
    r = Random.new
    number = r.rand(1...5)
    
    j = 0 
    title = Array.new 
    decsr = Array.new
    links = Array.new 
   
    url_wired = "http://www.wired.com/gadgetlab/tag/android-market/"

    doc = Nokogiri::HTML(open(url_wired))

    doc.css(".tag-android-market").each_with_index do |item, i|
      if number == i
        puts item.at_css("h2 a").text
        puts item.at_css("h2 a")[:href]     
        puts item.at_css("p:nth-child(4)").text
        break
      end   
    end

    j = j + 1

    url_mash_1 = "http://mashable.com/follow/search?q=windows+marketplace" 
    doc_mash = Nokogiri::HTML(open(url_mash_1)) 

    number_2 = r.rand(1...5) 

    doc_mash.css(".short").each_with_index do |item, i|
      if number_2 == i
        title[j] =  item.at_css(".headline").text
        links[j] = item.at_css(".headline")[:href] 
        url_spec = links[j] 
        doc3 = Nokogiri::HTML(open(url_spec)) 
        decsr[j] = doc3.at_css("p:nth-child(4)").text
        break 
      end
    end   