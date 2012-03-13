class SessionsController < ApplicationController
  def new
    @active[:login] = true
  end

  def create
    @active[:login] = true
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to user, :notice => 'Logged in!'
    else
      flash.now.alert = 'Invalid email or password.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Logged out!'
  end
end
