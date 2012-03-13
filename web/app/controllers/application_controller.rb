class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :empty_active
  helper_method :current_user, :logged_in?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user
  end

  def empty_active
    @active = {}
  end
end
