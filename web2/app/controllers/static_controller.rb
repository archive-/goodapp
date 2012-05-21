class StaticController < ApplicationController
  def index ; end
  def api ; end

  def search
    @search_query = params[:q]
  end
end
