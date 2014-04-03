class EmployeesController < ApplicationController
  def index
  	@employees = Employee.all
  end

  def show
  	employee = Employee.find(params[:id])
    @presenter = EmployeePresenter.new(self, view_context, employee)
  end

  def create
  	@employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employee_path(@employee.id) 
    end
  end


  def edit
  	@employee = Employee.find(params[:id])
  end

  def update
  	@employee = Employee.find(params[:id])
    @employee.update_attributes(employee_params)
    if @employee.valid?
      redirect_to employee_path(@employee.id) 
    end
  end

  def destroy
  	@employee = Employee.find(params[:id])
  	if @employee.destroy
  		redirect_to action: "index"
  	end
  end

  def association_form
    @employee = Employee.find(params[:employee_id])
  end

  def associate_rocket_action_to_employee
    @employee = Employee.find(params[:employee_id])
    rocket_action = RocketAction.find(associate_rocket_action_params[:rocket_action_id])
    has_success = AssociateRocketToEmployee.run(@employee, rocket_action)
    if has_success[:success]
      redirect_to employee_path(@employee.id)
    else
      @error = has_success[:message]
      render "association_form"
    end
  end

  private
    def employee_params
    	params.require(:employee).permit(:name, :email, :birth_date)
    end

    def associate_rocket_action_params
      params.require(:associate_rocket_action).permit(:rocket_action_id)
    end
end
