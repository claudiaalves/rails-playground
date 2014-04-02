require 'test_helper'

class EmployeeControllerTest < ActionController::TestCase
  def setup
    @controller = EmployeesController.new
  end
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    employee = Employee.new({
      name: "Claudia",
      email: "claudia@test.com",
      birth_date: 18.years.ago
      })
    assert false unless employee.save
    get :show, id: employee.id
    assert_response :success
  end

  test "should get create" do
    post :create, employee:{ name:"Cláudia", email: "claudia@test.com", birth_date: 18.years.ago}
    assert_response :redirect
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    employee = Employee.new({
      name: "Claudia",
      birth_date: 18.years.ago
      })
    assert false unless employee.save
    get :edit, id: employee.id
    assert_response :success
  end

  test "should get update" do
    employee = Employee.new({
      name: "Claudia",
      birth_date: 18.years.ago
    })
    assert false unless employee.save
    post :update, id: employee.id,  employee:{ name:"Cláudia", email: "claudia@test.pt", birth_date: 18.years.ago - 1.days}
    assert_response :redirect
  end

  test "should get destroy" do
    employee = Employee.new({
      name: "Claudia",
      email: "claudia@test.com",
      birth_date: 18.years.ago
      })
    assert false unless employee.save
    get :destroy, id: employee.id
    assert_response :redirect
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

    post :associate_rocket_action_to_employee, associate_rocket_action: {rocket_action_id: rocket_action.id}, employee_id: employee.id

    assert_response :redirect
    employee= Employee.find(employee.id)
    assert employee.total_points == 3
  end
end
