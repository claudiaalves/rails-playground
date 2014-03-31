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
      if (employee_id = params[:employee_id])!=nil
        employee = Employee.find(employee_id)
        rocket_action.employees << employee
        redirect_to rocket_action_path(rocket_action.id) 
      end
    end
  end

  def edit
    @rocket_action = RocketAction.find(params[:id])
  end

  def update
    @rocket_action = RocketAction.find(params[:id])
    @rocket_action.update_attributes(rocket_action_params)
    if @rocket_action.valid?
      redirect_to rocket_action_path(@rocket_action.id) 
    end
  end

  def destroy
    @rocket_action = RocketAction.find(params[:id])
    if @rocket_action.destroy
      redirect_to action: "index"
    end
  end

  private
    def rocket_action_params
      params.require(:rocket_action).permit(:name, :points)
    end
end
