require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  include ErrorString

  #não guardar empregados sem o nome
  test "not_save_employee_without_name" do
  	employee = Employee.new({
  		email: "claudia@test.com",
  		birth_date: "1991-03-03"
  	})
  	employee.save
  	assert employee.errors[:name][0] == NOME_OBRIGATORIO
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
  	assert employee2.errors[:name][0] == NOME_EXISTENTE
  end

  #não guardar empregados sem a data de aniversário
  test "not_save_employee_without_birth_date" do
  	employee = Employee.new({
  		name: "Claudia",
  		email: "claudia@test.com"
  	})
  	employee.save
  	assert employee.errors[:birth_date][0] == DATA_NASCIMENTO_OBRIGATORIO
  end
 
  #validar o requisito de o empregado ter mais de 18 anos
  test "not_valid_age_of_employee" do
  	employee = Employee.new({
  		name: "Claudia",
  		email: "claudia@test.com",
  		birth_date: Date.today - 18.years + 1.days
  	})
  	employee.save
 	assert employee.errors[:birth_date][0] == IDADE_MINIMA_18
  end

  test "valid_age_of_employee_18_years" do
  	employee = Employee.new({
  		name: "Claudia",
  		email: "claudia@test.com",
  		birth_date: Date.today - 18.years
  	})
  	employee.save
    assert employee.errors[:birth_date].count == 0

  end

  test "valid_age_of_employee_greater_than_18_years" do
  	employee = Employee.new({
  		name: "Claudia",
  		email: "claudia@test.com",
  		birth_date: Date.today - 18.years - 1.days
  	})
  	employee.save
    assert employee.errors[:birth_date].count == 0

  end

    test "not_valid_email_format" do
  	employee = Employee.new({
  		name: "Claudia",
  		email: "claudia@test",
  		birth_date: Date.today - 18.years
  	})
  	employee.save
    assert employee.errors[:email][0] == EMAIL_INVALIDO
  end

  test "valid_email" do
  	employee = Employee.new({
  		name: "Claudia",
  		email: "claudia@test.com",
  		birth_date: Date.today - 18.years - 1.days
  	})
  	employee.save
    assert employee.errors[:email].count == 0
  end

  test "accept_blank_email" do
  	employee = Employee.new({
  		name: "Claudia",
  		birth_date: Date.today - 18.years - 1.days
  	})
  	employee.save
    assert employee.errors[:email].count == 0
  end  


end
