class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :empty_active

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private

  def empty_active
    @active = {}
  end

end
