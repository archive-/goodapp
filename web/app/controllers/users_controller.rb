class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @active[:user] = true
    @user = User.find(params[:id])
  end

  def new
    @active[:register] = true
    @user = User.new
  end

  def create
    @active[:register] = true
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => 'Signed up!'
    else
      render 'new'
    end
  end
end
