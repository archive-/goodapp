class SessionsController < ApplicationController
  def new
  end

  def create
    dev = Dev.authenticate(params[:email], params[:password])
    if dev
      session[:dev_id] = dev.id
      redirect_to root_url, :notice => 'Logged in!'
    else
      flash.now.alert = 'Invalid email or password.'
      render 'new'
    end
  end

  def destroy
    session[:dev_id] = nil
    redirect_to root_url, :notice => 'Logged out!'
  end
end
