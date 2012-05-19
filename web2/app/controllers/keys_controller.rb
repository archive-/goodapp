class KeysController < ApplicationController
  def create
    @user = current_user
    @key = Key.new(params[:key])
    @key.user_id = @user.id
    if @key.save
      flash[:notice] = "Successfully added the key to your account."
      redirect_to referer
    else
      flash[:alert] = "There was an error in creating the key."
      redirect_to referer
    end
  end

  def destroy
    @user = current_user
    @key = Key.find_by_user_id_and_id(@user.id, params[:id])
    @key.destroy
    flash[:notice] = "Deleted the key successfully."
    redirect_to referer
  end
end
