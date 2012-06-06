class StaticController < ApplicationController
  def index
    @recent_apps = App.valids.order("created_at DESC").limit(4) # paginate
    
    @title, @decsr, @link = Rails.cache.fetch('scrape', :expires_in => 24.hours) do
      scrape
    end   
  end

  def dashboard
    @user = current_user
  end

  def search
    if !params[:q].blank?
      @search_query = params[:q]
      @apps = App.valids.where("title LIKE ?", "%#{@search_query}%")
      @users = User.where("name LIKE ?", "%#{@search_query}%")
    end
  end

  def api ; end
  def contact ; end
  def trust ; end

  def send_contact_email
    # TODO better validations -- make form_for with mail object?
    if params[:email] && !params[:email].blank?
      @email = params[:email]
    else
      flash.now.alert = "You must enter an email address!"
      render "contact"
      return
    end
    if params[:name] && !params[:name].blank?
      @name = params[:name]
    else
      flash.now.alert = "You must give a name!"
      render "contact"
      return
    end
    if params[:body] && !params[:body].blank?
      @body = params[:body]
    else
      flash.now.alert = "You must enter a message!"
      render "contact"
      return
    end
    if UserMailer.email(@email, @name, @body).deliver
      redirect_to contact_path, :notice => "Thanks for contacting us! We will *definitely* read it!"
    else
      flash.now.alert = "Message was not sent."
      render "contact"
    end
  end

  private

  def scrape
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
      title[j] = item.at_css("h2 a").text
      links[j] = item.at_css("h2 a")[:href]     
      decsr[j] = item.at_css("p:nth-child(4)").text
      j = j + 1
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
  end
end
