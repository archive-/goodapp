class AppsController < ApplicationController
  def new
    @user = current_user
    @app = App.new
    @apps = @user.apps.order("created_at DESC")
  end

  def create
    # TODO set aid to parent if user is uploading a new version of the app
    @user = current_user
    @app = App.new
    @key = Key.find_by_user_id_and_id(current_user.id, params[:app][:key_id])
    if @key.nil? || @user.valid_keys.index(@key).nil?
      flash[:alert] = "Please ensure you select one of your valid keys."
      redirect_to referer
      return
    end
    @app.key_id = @key.id
    unless params[:file]
      flash[:alert] = "You must upload a file to upload an app."
      redirect_to referer
      return
    end
    if @app.handle_upload(params[:file], @key)
      flash[:notice] = "Successfully uploaded your app to GoodApp. Processing now (see status below)."
      redirect_to referer
    else
      flash[:alert] = "There was a problem uploading your app to GoodApp."
      redirect_to referer
    end
  end

  def show
    @app = App.valids.find(params[:id])
    # TODO consider privacy?
    @user = params[:user_id] ? User.find(params[:user_id]) : @app.user
    @app_versions = App.valids.order("created_at ASC").find_all_by_aid(@app.aid)
    # root_app is most recent version
    @root_app = @app_versions[-1]
    respond_to do |format|
      format.html
      format.json { render json: @app }
    end
  end

  def mini
    # TODO consider privacy?
    @app = App.find(params[:id])
    render layout: false
  end
end
