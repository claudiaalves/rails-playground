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
    rocket_action = RocketAction.find(associate_rocket_action_params[:rocket_action_id])
    employee = Employee.find(params[:employee_id])
    employee.rocket_actions << rocket_action unless employee.rocket_actions.include? rocket_action
    employee.update_total_points
    redirect_to employee_path(params[:employee_id])
  end

  private
    def employee_params
    	params.require(:employee).permit(:name, :email, :birth_date)
    end

    def associate_rocket_action_params
      params.require(:associate_rocket_action).permit(:rocket_action_id)
    end
end
