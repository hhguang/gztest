require 'test_helper'

class PaperOrdersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paper_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paper_order" do
    assert_difference('PaperOrder.count') do
      post :create, :paper_order => { }
    end

    assert_redirected_to paper_order_path(assigns(:paper_order))
  end

  test "should show paper_order" do
    get :show, :id => paper_orders(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => paper_orders(:one).to_param
    assert_response :success
  end

  test "should update paper_order" do
    put :update, :id => paper_orders(:one).to_param, :paper_order => { }
    assert_redirected_to paper_order_path(assigns(:paper_order))
  end

  test "should destroy paper_order" do
    assert_difference('PaperOrder.count', -1) do
      delete :destroy, :id => paper_orders(:one).to_param
    end

    assert_redirected_to paper_orders_path
  end
end
