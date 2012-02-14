class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_active_hash
  helper_method :current_dev

  private

  def current_dev
    @current_dev ||= Dev.find(session[:dev_id]) if session[:dev_id]
  end

  def init_active_hash
    @active = {}
  end
end
