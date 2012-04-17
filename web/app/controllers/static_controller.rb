class StaticController < ApplicationController
  skip_authorization_check

  def home
    @title, @decsr, @link = Rails.cache.fetch('scrape', :expires_in => 24.hours) do
      scrape
    end
  end

  def about
    @active[:about] = true
  end

  def search
    @search_query = params[:q]
  end

  def contact
    @active[:contact] = true
  end

  def send_contact_mail
    # FIX THIS -- need validations -- make form_for with mail object?
    UserMailer.send_contact_mail(params[:email], params[:name], params[:message])
    redirect_to root_url, :notice => 'Message successfully sent.'
  end

  def api
    @active[:api] = true
    @routes = Rails.application.routes.routes
  end

  private

  def scrape
    require 'nokogiri'
    require 'open-uri'

    # TODO -- since not articles have a description in the same place, sometime
    # description comes out to be empty -- which causes an exception and page wont load
    # need to figure out what to do if that happens: look for another paragraph to scrape?
    # or just look for a different article?

    # for comments =begin =end
    # would like to display a total of 5 article
    # would like each time a page loads for different articles to be selected
    r = Random.new
    number = r.rand(1...5) # => 22
    j = 0
    title = Array.new
    decsr = Array.new
    links = Array.new

    # first source - WIRED
    url_wired = "http://www.wired.com/gadgetlab/tag/android-market/"
    doc = Nokogiri::HTML(open(url_wired))


    doc.css(".tag-android-market").each_with_index do |item, i|
      if number == i
        title[j] = item.at_css("h2 a").text
        links[j] = item.at_css("h2 a")[:href]
        decsr[j] = item.at_css("p:nth-child(4)").text
        break
      end
    end
    j = j + 1

    # second sourse - MASHABLE
    url_mash_1 = "http://mashable.com/follow/search?q=windows+marketplace"
    doc_mash = Nokogiri::HTML(open(url_mash_1))

    number_2 = r.rand(1...6)

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
    j = j +1
    url_mash_2 = "http://mashable.com/follow/search?q=android+market"
    doc_mash = Nokogiri::HTML(open(url_mash_2))

    number_3 = r.rand(1...6)

    doc_mash.css(".short").each_with_index do |item, i|
      if number_3 == i
        title[j] =  item.at_css(".headline").text
        links[j] = item.at_css(".headline")[:href]
        url_spec = links[j]
        doc3 = Nokogiri::HTML(open(url_spec))
        # TODO check if doc3.at_css returns nil
        decsr[j] = doc3.at_css("p:nth-child(4)").text
        break
      end
    end
    j = j + 1
    url_mash_3 = "http://mashable.com/follow/search?q=apple+store"
    doc_mash = Nokogiri::HTML(open(url_mash_3))

    number_4 = r.rand(1...6)

    doc_mash.css(".short").each_with_index do |item, i|
      if number_4 == i
        title[j] =  item.at_css(".headline").text
        links[j] = item.at_css(".headline")[:href]
        url_spec = links[j]
        doc3 = Nokogiri::HTML(open(url_spec))
        decsr[j] = doc3.at_css("p:nth-child(4)").text
        break
      end
    end
    j = j + 1

    # third source - TECH CRUNCH - will only grab the top etry..wont iterate thorugh them all
    url_tech = "http://techcrunch.com/mobile/"
    doc_tech = Nokogiri::HTML(open(url_tech))

    doc_tech.css(".left-container").each_with_index do |item, i|
      title[j] =  item.at_css(".embedded-image-post .headline a").text
      links[j] = item.at_css(".embedded-image-post .headline a")[:href]
      decsr[j] = item.at_css("p:nth-child(1)").text
    end

    return title, decsr, links
  end
end
