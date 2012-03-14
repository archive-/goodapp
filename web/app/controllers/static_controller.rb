class StaticController < ApplicationController
  skip_authorization_check

  def home
  end

  def about
    @active[:about] = true
  end

  def search
  end

  def contact
    @active[:contact] = true
  end

  def submit
    if request.post?
    UserMailer.deliver_message_from_visitor(params[:email], params[:message])
    redirect_to root_url, :notice => 'Message successfully sent.'
    end
  end

  def api
    @active[:api] = true
    @routes = Rails.application.routes.routes
  end
end
