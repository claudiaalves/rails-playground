
class UpdateTotalPointsEmployee
  def initialize(employee)
    @employee = employee
  end

  def may_run?
    @employee.valid? 
  end

  def run
    @employee.update_attributes(:total_points => @employee.rocket_actions.sum('points'))
  end

  def self.run(employee)
    iteractor = self.new(employee)
    iteractor.run
  end
end