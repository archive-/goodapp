class KeysController < ApplicationController
  def create
    session[:tab] = :keys
    @user = current_user
    @key = Key.new(params[:key])
    @key.user_id = @user.id
    if @key.email_key?
      @key.progress(60, "Email: Sent confirmation email to <#{@key.kee}>.")
      # TODO validate email?
      KeyMailer.email(@key.kee, @key.id).deliver
      return redirect_to settings_path(anchor: "keys-pane"),
        notice: "Successfully upload your key to GoodApp. Processing now (see status below)."
    else
      if @key.title.blank?
        # TODO TODO [in lots of places] needs to be render!!
        return redirect_to settings_path(anchor: "keys-pane"),
          alert: "You must give your key a title."
      end
      if @key.kee.blank?
        # TODO TODO [in lots of places] needs to be render!!
        return redirect_to settings_path(anchor: "keys-pane"),
          alert: "The key cannot be blank!"
      end
      if @key.handle_upload
        return redirect_to settings_path(anchor: "keys-pane"),
          notice: "Successfully upload your key to GoodApp. Processing now (see status below)."
      else
        return redirect_to settings_path(anchor: "keys-pane"),
          alert: "There was an error in creating the key."
      end
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
    # TODO check @key (is owned by current_user, etc.)
    if @key.confirmed_at
      return redirect_to settings_path(anchor: "keys-pane"),
        alert: "Key already confirmed!"
    end
    if @key.confirmation_token == params[:confirmation_token]
      if !@key.email_key?
        # create email key for email used as confirmation
        email_key = Key.new({user_id: @key.user_id, title: @key.confirmation_email,
          kee: @key.confirmation_email, status: 100, proper: true,
          style: :email, confirmed_at: Time.now}, without_protection: true)
        email_key.update_rating
      end
      @key.confirmed_at = Time.now ; @key.save
      @key.update_rating
      @key.progress(100)
      return redirect_to settings_path(anchor: "keys-pane"),
        notice: "Key successfully confirmed."
    else
      return redirect_to settings_path(anchor: "keys-pane"),
        alert: "Key was not confirmed properly (improper confirmation token)."
    end
  end

  def destroy
    @user = current_user
    @key = Key.find_by_user_id_and_id(@user.id, params[:id])
    # TODO check key
    @key.destroy
    flash[:notice] = "Deleted the key successfully."
    redirect_to settings_path(anchor: "keys-pane")
  end
end
