class EmployeesController < ApplicationController
  def index
  	@employees = Employee.all
  end

  def show
  	@employee = Employee.find(params[:id])
  end

  def create
  	@employee = Employee.new(employee_params)
  	@employee.save
  	if !@employee.errors.any? 
  	  redirect_to employee_path(@employee.id) 
  	end
  end


  def edit
  	@employee = Employee.find(params[:id])
  end

  def update
  	@employee = Employee.find(params[:id])
  	@employee.update(name: employee_params[:name])
  	@employee.update(email: employee_params[:email])
  	@employee.update(birth_date: employee_params[:birth_date])
  	if !@employee.errors.any? 
  	  redirect_to employee_path(@employee.id) 
  	end
  end

  def destroy
  	@employee = Employee.find(params[:id])
  	if @employee.destroy
  		redirect_to action: "index"
  	end
  end

  private
    def employee_params
    	params.require(:employee).permit(:name, :email, :birth_date)
    end
end
