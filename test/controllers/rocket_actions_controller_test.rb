require 'test_helper'

class RocketActionsControllerTest < ActionController::TestCase
  def setup
    @controller = RocketActionsController.new
  end
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    rocket_action = RocketAction.new({
      name: "rocket test",
      points: 3
      })
    assert false unless rocket_action.save
    get :show , id:rocket_action.id
    assert_response :success
  end

  test "should get create" do
    post :create, rocket_action: { name:'Rocket Test', points: '3'}
    assert_response :success
  end
end
