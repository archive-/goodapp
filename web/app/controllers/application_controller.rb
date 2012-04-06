class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :empty_active
  helper_method :current_user, :logged_in?, :login_required

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private

  def login_required
    return true if current_user
    flash[:alert] = 'Please login to continue.'
    session[:return] = request.url
    redirect_to root_url
    return false
  end

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
