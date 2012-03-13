class UsersController < ApplicationController
  before_filter :activate_user
  load_and_authorize_resource :unless => [:new, :create]

  def index
  end

  def show
  end

  def new
    @active[:register] = true
  end

  def create
    @active[:register] = true
    if @user.save
      redirect_to root_url, :notice => 'Signed up!'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
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
