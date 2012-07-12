require 'test_helper'

class QxesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qx" do
    assert_difference('Qx.count') do
      post :create, :qx => { }
    end

    assert_redirected_to qx_path(assigns(:qx))
  end

  test "should show qx" do
    get :show, :id => qxes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => qxes(:one).to_param
    assert_response :success
  end

  test "should update qx" do
    put :update, :id => qxes(:one).to_param, :qx => { }
    assert_redirected_to qx_path(assigns(:qx))
  end

  test "should destroy qx" do
    assert_difference('Qx.count', -1) do
      delete :destroy, :id => qxes(:one).to_param
    end

    assert_redirected_to qxes_path
  end
end
