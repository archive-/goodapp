class KeysController < ApplicationController
  def create
    @user = current_user
    @key = Key.new(params[:key])
    @key.user_id = @user.id
    if @key.kee.blank?
      # TODO TODO [in lots of places] needs to be render!!
      flash[:alert] = "The key cannot be blank!"
      redirect_to edit_user_path(anchor: "keys-pane")
      return
    end
    if @key.handle_upload
      flash[:notice] = "Successfully upload your key to GoodApp. Processing now (see status below)."
      redirect_to edit_user_path(anchor: "keys-pane")
    else
      flash[:alert] = "There was an error in creating the key."
      redirect_to edit_user_path(anchor: "keys-pane")
    end
  end

  def mini
    @user = current_user
    @key = Key.find_by_user_id_and_id(current_user.id, params[:id])
    # TODO check key
    render layout: false
  end

  def confirm
    # TODO make sure they are logged in for this action
    @key = Key.find(params[:id])
    if @key.confirmed_at
      flash[:notice] = "Key already confirmed!"
      redirect_to edit_user_path(anchor: "keys-pane")
      return
    end
    # TODO check key
    if @key.confirmation_token == params[:confirmation_token]
      @key.confirmed_at = Time.now ; @key.save
      @key.progress(100)
      flash[:notice] = "Key successfully confirmed."
      redirect_to edit_user_path(anchor: "keys-pane")
    else
      flash[:alert] = "Key was not confirmed properly (improper confirmation token)."
      redirect_to edit_user_path(anchor: "keys-pane")
    end
  end

  def destroy
    @user = current_user
    @key = Key.find_by_user_id_and_id(@user.id, params[:id])
    # TODO check key
    @key.destroy
    flash[:notice] = "Deleted the key successfully."
    redirect_to edit_user_path(anchor: "keys-pane")
  end
end
