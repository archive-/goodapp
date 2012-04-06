class AppsController < ApplicationController
  load_and_authorize_resource
  include FeedbackOptions

  def index
  end

  def show
    @options = get_options
    # @feedback = @app.basic_feedbacks
    @survey = Survey.first
    @response_set = ResponseSet.create(:survey => @survey, :user_id => current_user.id)
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
