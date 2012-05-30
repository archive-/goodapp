class StaticController < ApplicationController
  def index
    @recent_apps = App.valids.order("created_at DESC").limit(4) # paginate
  end

  def dashboard
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
end
