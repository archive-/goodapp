class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_active_hash

  private

  def init_active_hash
    @active = {}
  end
end
