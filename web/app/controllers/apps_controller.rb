class AppsController < ApplicationController
  def index
    @apps = App.all
  end

  def show
    @app = App.find(params[:id])
  end

  def new
    @app = App.new
  end

  def create
    @app = App.new(params[:app])
    if @app.save

    else

    end
  end

  def flag
  end

  def new
  end
end
