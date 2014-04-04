class RocketAction < ActiveRecord::Base
  include ErrorString
  validates :name, presence: {message: NAME_REQUIRED}
  validates :points, numericality: {greater_than_or_equal_to: 0, only_integer: true, message: POINTS_REQUIRED_INTEGER_NUMBER}
  has_many :employee_rocket_action_associations
  has_many :employees, :through => :employee_rocket_action_associations
end
