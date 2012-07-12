require 'test_helper'

class ScoreFilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:score_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create score_file" do
    assert_difference('ScoreFile.count') do
      post :create, :score_file => { }
    end

    assert_redirected_to score_file_path(assigns(:score_file))
  end

  test "should show score_file" do
    get :show, :id => score_files(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => score_files(:one).to_param
    assert_response :success
  end

  test "should update score_file" do
    put :update, :id => score_files(:one).to_param, :score_file => { }
    assert_redirected_to score_file_path(assigns(:score_file))
  end

  test "should destroy score_file" do
    assert_difference('ScoreFile.count', -1) do
      delete :destroy, :id => score_files(:one).to_param
    end

    assert_redirected_to score_files_path
  end
end
