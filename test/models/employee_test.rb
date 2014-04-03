require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  include ErrorString

  #should not save employee without name
  test "not_save_employee_without_name" do
  	employee = Employee.new({
  		email: "claudia@test.com",
  		birth_date: "1991-03-03"
  	})
  	employee.save
  	assert employee.errors[:name][0] == NAME_REQUIRED
  end

  test "not_save_employees_with_same_name" do
  	employee1 = Employee.new({
  		name:"Claudia",
  		email: "claudia@test.com",
  		birth_date: "1991-03-03"
  	})
  	assert employee1.save
  	employee2 = Employee.new({
  		name:"Claudia",
  		email: "alves@test.com",
  		birth_date: "1988-03-03"
  	})
  	employee2.save
  	assert employee2.errors[:name][0] == NAME_HAS_ALREADY_BEEN_TAKEN 
  end

  #should not save employees without birth date
  test "not_save_employee_without_birth_date" do
  	employee = Employee.new({
  		name: "Claudia",
  		email: "claudia@test.com"
  	})
  	employee.save
  	assert employee.errors[:birth_date][0] == BIRTH_DATE_REQUIRED
  end
 
  #should not save employee with less than 18 years
  test "not_valid_age_of_employee" do
  	employee = Employee.new({
  		name: "Claudia",
  		email: "claudia@test.com",
  		birth_date: 18.years.ago + 1.days
  	})
  	employee.save
 	assert employee.errors[:birth_date][0] == MINIMUM_AGE_18
  end

  test "valid_age_of_employee_18_years" do
  	employee = Employee.new({
  		name: "Claudia",
  		email: "claudia@test.com",
  		birth_date: 18.years.ago
  	})
  	employee.save
    assert employee.errors[:birth_date].count == 0

  end

  test "valid_age_of_employee_greater_than_18_years" do
  	employee = Employee.new({
  		name: "Claudia",
  		email: "claudia@test.com",
  		birth_date: 18.years.ago - 1.days
  	})
  	employee.save
    assert employee.errors[:birth_date].count == 0

  end

    test "not_valid_email_format" do
  	employee = Employee.new({
  		name: "Claudia",
  		email: "claudia@test",
      birth_date: 18.years.ago
  	})
  	employee.save
    assert employee.errors[:email][0] == INVALID_EMAIL
  end

  test "valid_email" do
  	employee = Employee.new({
  		name: "Claudia",
  		email: "claudia@test.com",
  		birth_date: 18.years.ago - 1.days
  	})
  	employee.save
    assert employee.errors[:email].count == 0
  end

  test "accept_blank_email" do
  	employee = Employee.new({
  		name: "Claudia",
  		birth_date: 18.years.ago - 1.days
  	})
  	employee.save
    assert employee.errors[:email].count == 0
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
    
    assocIteractor = AssociateRocketToEmployee.new(employee.id, rocket_action.id)
    assocIteractor.associate 
    assert assocIteractor.associated_with_success?
    assert Employee.find(employee.id).total_points == 3
  end
end
