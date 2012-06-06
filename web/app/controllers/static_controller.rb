class StaticController < ApplicationController

  def index
    @recent_apps = App.valids.order("created_at DESC").limit(4) # paginate
    @tlds = Rails.cache.fetch("scraped", expires_in: 24.hours) do
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

  def scrape_wired(doc, article_number=Random.rand(5)+1)
    title = link = description = nil
    doc.css(".tag-android-market").each_with_index do |item, i|
      if i == article_number
        dom_a = item.at_css("h2 a")
        title = dom_a.text
        link = dom_a[:href]
        dom_description = item.at_css("p:nth-child(4)")
        unless dom_description.nil?
          description = dom_description.text
        end
        break
      end
    end
    {title: title, link: link, description: description}
  end

  def scrape_mashable(doc, article_number=Random.rand(6)+1)
    title = link = description = nil
    doc.css(".short").each_with_index do |item, i|
      if i == article_number
        title = item.at_css(".headline").text
        link = item.at_css(".headline")[:href]
        subdoc = Nokogiri::HTML(RestClient.get(link))
        dom_description = subdoc.at_css("p:nth-child(4)")
        unless dom_description.nil?
          description = dom_description.text
        end
      end
    end
    {title: title, link: link, description: description}
  end

  def scrape_techcrunch(doc)
    title = link = description = nil
    doc.css(".left-container").each_with_index do |item, i|
      dom_title = item.at_css(".embedded-image-post .headline a")
      title = dom_title.text
      link = dom_title[:href]
      dom_description = item.at_css("p:nth-child(1)")
      unless dom_description.nil?
        description = dom_description.text
      end
    end
    {title: title, link: link, description: description}
  end

  def scrape
    # source => url
    sources = {
      wired:
        "http://www.wired.com/gadgetlab/tag/android-market/",
      mashable_windows:
        "http://mashable.com/follow/search?q=windows+marketplace",
      mashable_android:
        "http://mashable.com/follow/search?q=android+marketplace",
      mashable_apple:
        "http://mashable.com/follow/search?q=apple+marketplace",
      techcrunch:
        "http://techcrunch.com/mobile/"}

    tlds = []
    sources.each_with_index do |(source, url), i|
      doc = Nokogiri::HTML(RestClient.get(url))
      tld = send("scrape_#{source.to_s.split("_")[0]}", doc)
      unless tld.any? {|k, v| v.nil?}
        tlds << tld
      end
    end
    tlds
  end
end
