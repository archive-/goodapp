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

  def api
    @active[:api] = true
    @routes = Rails.application.routes.routes
  end
end
