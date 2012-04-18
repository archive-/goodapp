class AppsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    @survey = Survey.first
    if current_user
    @response_set = ResponseSet.find_or_create_by_user_id(current_user.id,
        :survey => @survey)
    end
  end

  def new
  end

  def create
    if @app.save
      # TODO use build
      owned_app = AppOwnership.create(:user_id => current_user.id, :app_id => @app.id)
      redirect_to root_url, :notice => 'Successfully uploaded your App.'
    else
      flash.now.alert = 'App was not uploaded properly.'
      render 'new'
    end
  end

  def flag
  end
end
