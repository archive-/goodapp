class AppsController < ApplicationController
  def create
    @user = current_user
    @key = Key.find(params[:app][:key_id])
    if App.handle_upload(params[:file])
      flash[:notice] = "Successfully uploaded the app to GoodApp."
      redirect_to referer
    else
      flash[:alert] = "There was a problem upload the app to GoodApp."
      redirect_to referer
    end
  end
end
