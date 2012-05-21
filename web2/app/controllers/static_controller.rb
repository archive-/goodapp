class StaticController < ApplicationController
  def index
    @recent_apps = App.order("created_at DESC").limit(4) # paginate
  end
  def api ; end
end
