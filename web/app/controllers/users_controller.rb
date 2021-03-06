class UsersController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json {
        @response = []
        unless params[:email].blank?
          email_key = Key.find_by_kee(params[:email])
          unless email_key.nil?
            @response = [User.find(email_key.user_id)]
          end
        end
        render json: @response
      }
    end
  end

  def show
    @user = User.find(params[:id])
    @apps = @user.valid_apps
    @endorsements = @user.endorsements_as_endorsee
    respond_to do |format|
      format.html
      format.json {render json: @user}
    end
  end

  def edit
    # TODO can't decide on this -- this is better for github actions
    session[:tab] ||= :profile
    @user = current_user
  end

  def update
    @user = current_user
    # TODO less hacky?
    session[:tab] = params[:user][:about] ? :profile : :account_settings
    if current_user.update_attributes(params[:user])
      return redirect_to settings_path, notice: "Successfully updated your settings."
    else
      flash.now.alert = "There was an issue in updating your settings."
      return render "edit"
    end
  end

  def github_sync
    session[:tab] = :github
    @user = current_user
    unless @user.github_account
      flash.now.alert = "You can't sync your Github account if it isn't connected!"
      return render "new"
    end
    GithubAccount.sync(@user.id)
    return redirect_to referer, notice: "Your Github account was successfully synced."
  end

  def github_connect
    session[:tab] = :github
    @user = current_user
    @key = Key.find_by_user_id_and_id(current_user.id, params[:key_id])
    unless @key
      flash.now.alert = "You must supply a valid key that you own!"
      return render "edit"
    end
    if params[:username].blank?
      flash.now.alert = "Github username can't be blank!"
      return render "edit"
    end
    unless @key.email_key?
      flash.now.alert = "Connecting your Github account requires an email key."
      return render "edit"
    end
    begin
      json = RestClient.get("https://api.github.com/users/#{params[:username]}")
      github_user = ActiveSupport::JSON.decode(json)
      if github_user["email"] == @key.title
        GithubAccount.sync(current_user.id, github_user["login"])
        return redirect_to settings_path, notice: "Your Github account was successfully connected, #{params[:username]}."
      else
        flash.now.alert = "Your email key does not match the Github email for that username."
        return render "edit"
      end
    rescue RestClient::ResourceNotFound
      flash.now.alert = "That Github username does not exist!"
      return render "edit"
    end
  end
end
