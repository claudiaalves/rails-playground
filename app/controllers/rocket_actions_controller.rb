class RocketActionsController < ApplicationController
  def index
    @rocket_actions = RocketAction.all
  end

  def new
    @employee_id = params[:employee_id] 
  end
 
  def show
    @rocket_action = RocketAction.find(params[:id])
  end

  def create
    rocket_action = RocketAction.new(rocket_action_params)
    if rocket_action.save
      employee_id = params[:employee_id]
      if employee_id.present?
        employee = Employee.find(employee_id)
        rocket_action.employees << employee
        employee.update_total_points
        redirect_to rocket_action_path(rocket_action.id) 
      end
    end
  end
  private
    def rocket_action_params
      params.require(:rocket_action).permit(:name, :points)
    end
end
