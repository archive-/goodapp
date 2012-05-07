class UsersController < ApplicationController
  before_filter :activate_user
  load_and_authorize_resource

  def index
  end

  def show
    @endorsement = Endorsement.new
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice => 'Successfully updated your account settings.'
    else
      flash.now.alert = 'A problem occured when trying to update your account settings.'
      render 'new'
    end
  end

  def upgrade
    current_user.add_role :dev
    redirect_to current_user, :notice => 'Your account is now a developer account.'
  end

  def downgrade
    current_user.remove_role :dev
    redirect_to current_user, :notice => 'Your account is no longer a developer account.'
  end

  private

  def activate_user
    @active[:user] = true
  end
end
