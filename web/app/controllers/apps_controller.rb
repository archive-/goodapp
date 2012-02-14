class AppsController < ApplicationController
  def index
    @apps = App.all
  end

  def show
    @app = App.find(params[:id])
  end

  def flag
  end
end
