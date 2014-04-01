require 'test_helper'

class RocketActionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  #total_points should update when a RocketAction is associated to an Employee
  test "update_total_points_when_associate_rocket_to_Employee" do
    employee = Employee.new({
      name: "Claudia",
      email: "claudia@test.com",
      birth_date: 18.years.ago
      })
    assert false unless employee.save

    rocket_action = RocketAction.new({
      name: "rocket test",
      points: 3
      })
    assert false unless rocket_action.save

    post :associate_rocket_action_to_employee, associate_rocket_action: {rocket_action_id: rocket_action.id}, employee_id: employee.id)

    assert_response :success
    assert employee.total_points == 3
  end
end
