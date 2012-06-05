class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :referer
  before_filter :set_action_mailer_host

  private

  def set_action_mailer_host
    ActionMailer::Base.default_url_options = {host: request.host_with_port}
  end

  # TODO please no
  def referer
    Rails.application.routes.recognize_path(request.referer)
  end
end
