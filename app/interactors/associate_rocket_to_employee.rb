class AssociateRocketToEmployee
  include ErrorString

	def initialize(employee, rocket)
    @employee = employee
    @rocket_action = rocket
	end

  def may_run?
    @employee.valid? && @rocket_action.valid? && (@employee.rocket_actions.exclude? @rocket_action)
  end

	def run
    @employee.transaction do
      return message(false, ASSOCIATION_BETWEEN_ROCKET_AND_EMPLOYEE_ALREADY_EXIST) unless may_run? 
  		@employee.rocket_actions << @rocket_action
      @employee.update_total_points
      @employee.valid? ? (return message(true)): (raise ActiveRecord::Rollback)
    end
    message(false, ASSOCIATE_ROCKET_TO_EMPLOYEE_FAIL)
	end

  def self.run(employee, rocket)
    iteractor = self.new(employee, rocket)
    iteractor.run
  end

  private
  def message(success, message = nil )
    {success: success, message: message}
  end
end