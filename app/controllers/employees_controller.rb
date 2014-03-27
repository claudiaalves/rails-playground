class EmployeesController < ApplicationController
  def index
  	@employees = Employee.all
  end

  def show
  	@employee = Employee.find(params[:id])
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

  private
    def employee_params
    	params.require(:employee).permit(:name, :email, :birth_date)
    end
end
