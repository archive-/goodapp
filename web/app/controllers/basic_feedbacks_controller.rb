class BasicFeedbacksController < ApplicationController
  # GET /basic_feedbacks
  # GET /basic_feedbacks.json
  def index
    @basic_feedbacks = BasicFeedback.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @basic_feedbacks }
    end
  end

  # GET /basic_feedbacks/1
  # GET /basic_feedbacks/1.json
  def show
    @basic_feedback = BasicFeedback.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @basic_feedback }
    end
  end

  # GET /basic_feedbacks/new
  # GET /basic_feedbacks/new.json
  def new
    @basic_feedback = BasicFeedback.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @basic_feedback }
    end
  end

  
  # POST /basic_feedbacks
  # POST /basic_feedbacks.json
  # good = "good_1::good_2::good_5"
  def create
    if params[:app_id]
      app = App.find(params[:app_id])
    else
      app = nil
    end
    @basic_feedback = BasicFeedback.new(params[:basic_feedback])
    @basic_feedback.user = current_user
    good = ""
    good_score = 0
    params[:good].each_pair do |key, v|
      if v == "1"
        good = good + "#{key}::"
        good_score = good_score + 1
      end
    end
    @basic_feedback.good = good; 
    bad = ""
    bad_score = 0
    params[:bad].each_pair do |key, v|
      if v == "1"
        bad = bad + "#{key}::"
        bad_score = bad_score + 1
      end  
    end
    @basic_feedback.bad = bad; 
    @basic_feedback.score = (((good_score + bad_score)/20.0) - (bad_score/10.0) ) * 100   
    @basic_feedback.app = app

    respond_to do |format|
      if @basic_feedback.save
        format.html { redirect_to app, notice: 'Basic feedback was successfully created.' }
        format.json { render json: app, status: :created, location: @basic_feedback }
      else
        format.html { render action: "new" }
        format.json { render json: @basic_feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /basic_feedbacks/1
  # PUT /basic_feedbacks/1.json
  def update
    @basic_feedback = BasicFeedback.find(params[:id])

    respond_to do |format|
      if @basic_feedback.update_attributes(params[:basic_feedback])
        format.html { redirect_to @basic_feedback, notice: 'Basic feedback was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @basic_feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /basic_feedbacks/1
  # DELETE /basic_feedbacks/1.json
  def destroy
    @basic_feedback = BasicFeedback.find(params[:id])
    @basic_feedback.destroy

    respond_to do |format|
      format.html { redirect_to basic_feedbacks_url }
      format.json { head :no_content }
    end
  end
end
