class Employee < ActiveRecord::Base
  include ErrorString
  validates :name, uniqueness: { message: NOME_EXISTENTE }, presence:{ message: NOME_OBRIGATORIO}
  validates :email, format: { allow_blank: true, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i , message: EMAIL_INVALIDO}
  validate :greater_or_equal_than_18_years_old
  validates :birth_date, presence:{ message: DATA_NASCIMENTO_OBRIGATORIO}
  private
  def greater_or_equal_than_18_years_old
  	if self.birth_date != nil
  	  limit_date = Date.today - 18.years
  	  errors.add(:birth_date, IDADE_MINIMA_18) if self.birth_date > limit_date
    end
  end

end

