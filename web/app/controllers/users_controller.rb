class UsersController < ApplicationController
  before_filter :activate_user

  def index
    @users = User.all
  end

  def show
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  end

  def upgrade
    @user = current_user
    @user.is_dev = true
    @user.save
    redirect_to current_user, :notice => 'Your account is now a developer account.'
  end

  def downgrade
    @user = current_user
    @user.is_dev = false
    @user.save
    redirect_to current_user, :notice => 'Your account is no longer a developer account.'
  end

  private

  def activate_user
    @active[:user] = true
  end
end
