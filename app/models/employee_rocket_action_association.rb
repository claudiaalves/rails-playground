class EmployeeRocketActionAssociation < ActiveRecord::Base
  belongs_to :employee
  belongs_to :rocket_action
end
