class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :referer

  private

  # TODO please no
  def referer
    Rails.application.routes.recognize_path(request.referer)
  end
end
