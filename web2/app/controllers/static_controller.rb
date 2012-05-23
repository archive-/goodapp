class StaticController < ApplicationController
  def index
    @recent_apps = App.valids.order("created_at DESC").limit(4) # paginate
  end

  def api ; end

  def search
    @search_query = params[:q]
  end

  def send_contact_mail
    # FIX THIS -- need validations -- make form_for with mail object?
    if params[:email] && !params[:email].blank?
      @email = params[:email]
    else
      flash[:error] = 'You must enter an email address!'
      redirect_to :action => 'contact'
      return
    end
    if params[:name] && !params[:name].blank?
      @name = params[:name]
    else
      flash[:error] = 'You must give a name!'
      redirect_to :action => 'contact'
      return
    end
    if params[:message] && !params[:message].blank?
      @message = params[:name]
    else
      flash[:error] = 'You must enter a message!'
      redirect_to :action => 'contact'
      return
    end
    if UserMailer.send_contact_mail(@email, @name, @message)
      redirect_to root_url, :notice => 'Message successfully sent.'
    else
      redirect_to root_url, :notice => 'Message was not sent.'
    end
  end
end
