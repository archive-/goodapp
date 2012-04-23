class AppsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    @app = App.find(params[:id])
    if current_user
      @basic_feedback = BasicFeedback.find_or_initialize_by_user_and_app(current_user, self)
    end
  end

  def new
  end

  def create
    if @app.save
      # TODO use build
      owned_app = AppOwnership.create(:user_id => current_user.id, :app_id => @app.id)
      redirect_to @app, :notice => 'Successfully uploaded your App.'
    else
      flash.now.alert = 'App was not uploaded properly.'
      render 'new'
    end
  end

  def flag
  end
end
