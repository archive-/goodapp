require 'test_helper'

class BasicFeedbacksControllerTest < ActionController::TestCase
  setup do
    @basic_feedback = basic_feedbacks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:basic_feedbacks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create basic_feedback" do
    assert_difference('BasicFeedback.count') do
      post :create, basic_feedback: @basic_feedback.attributes
    end

    assert_redirected_to basic_feedback_path(assigns(:basic_feedback))
  end

  test "should show basic_feedback" do
    get :show, id: @basic_feedback
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @basic_feedback
    assert_response :success
  end

  test "should update basic_feedback" do
    put :update, id: @basic_feedback, basic_feedback: @basic_feedback.attributes
    assert_redirected_to basic_feedback_path(assigns(:basic_feedback))
  end

  test "should destroy basic_feedback" do
    assert_difference('BasicFeedback.count', -1) do
      delete :destroy, id: @basic_feedback
    end

    assert_redirected_to basic_feedbacks_path
  end
end
