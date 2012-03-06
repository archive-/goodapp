class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_active_hash
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def init_active_hash
    @active = {}
  end
end
