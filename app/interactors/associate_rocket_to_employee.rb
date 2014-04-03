class AssociateRocketToEmployee
  include ErrorString
	def initialize(employee, rocket)
    @employee = employee
    @rocket_action = rocket
	end

  def may_run?
    @employee.valid? && @rocket_action.valid?
  end

	def run
    @employee.transaction do
  		@employee.rocket_actions << @rocket_action unless @employee.rocket_actions.include? @rocket_action
      @employee.update_total_points
      if (@employee.valid?)
        return {success: true}
      else
        raise ActiveRecord::Rollback
      end
    end
    return { success: false, message: ASSOCIATE_ROCKET_TO_EMPLOYEE_FAIL}
	end

  def self.run(employee, rocket)
    iteractor = self.new(employee, rocket)
    iteractor.run
  end
end