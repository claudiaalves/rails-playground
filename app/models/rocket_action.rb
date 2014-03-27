class RocketAction < ActiveRecord::Base
	validates :points, numericality: {greater_than_or_equal_to: 0, only_integer: true}
	has_and_belongs_to_many :employees
end
