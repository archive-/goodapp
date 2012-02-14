class DevsController < ApplicationController
  def index
    @devs = Dev.all
  end

  def show
    @dev = Dev.find(params[:id])
  end

  def new
    @dev = Dev.new
  end

  def create
    @dev = Dev.new(params[:dev])
    if @dev.save
      redirect_to root_url, :notice => 'Signed up!'
    else
      render 'new'
    end
  end
end
