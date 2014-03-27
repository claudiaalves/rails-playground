class Employee < ActiveRecord::Base
  include ErrorString
  validates :name, uniqueness: { message: NAME_HAS_ALREADY_BEEN_TAKEN  }, presence:{ message: NAME_REQUIRED}
  validates :email, format: { allow_blank: true, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , message: INVALID_EMAIL}
  validate :greater_or_equal_than_18_years_old
  validates :birth_date, presence:{ message: BIRTH_DATE_REQUIRED}
  private
  def greater_or_equal_than_18_years_old
  	if self.birth_date != nil
  	  errors.add(:birth_date, MINIMUM_AGE_18) if self.birth_date > 18.years.ago
    end
  end

end

