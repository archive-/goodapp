class StaticController < ApplicationController
  include StaticHelper
  skip_authorization_check

  def home
    @title, @decsr, @link = scrape
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
end
