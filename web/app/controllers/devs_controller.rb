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
end
