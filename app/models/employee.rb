class Employee < ActiveRecord::Base
  include ErrorString
  validates :name, uniqueness: { message: NAME_HAS_ALREADY_BEEN_TAKEN  }, presence:{ message: NAME_REQUIRED}
  validates :email, format: { allow_blank: true, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , message: INVALID_EMAIL}
  validate :greater_or_equal_than_18_years_old
  validates :birth_date, presence:{ message: BIRTH_DATE_REQUIRED}
  validates :total_points, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  has_many :employee_rocket_action_associations
  has_many  :rocket_actions, :through => :employee_rocket_action_associations

  def update_total_points
    self.update_attribute(:total_points, self.rocket_actions.sum('points'))  
  end

  private
  def greater_or_equal_than_18_years_old
  	if self.birth_date != nil
  	  errors.add(:birth_date, MINIMUM_AGE_18) if self.birth_date > 18.years.ago
    end
  end
end

