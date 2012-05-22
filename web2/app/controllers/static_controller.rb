class StaticController < ApplicationController
  def index
    @recent_apps = App.valids.order("created_at DESC").limit(4) # paginate
  end

  def api ; end

  def search
    @search_query = params[:q]
  end
end
