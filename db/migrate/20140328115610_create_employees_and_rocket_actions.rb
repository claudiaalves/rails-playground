class CreateEmployeesAndRocketActions < ActiveRecord::Migration
  def change
    create_table :employees_rocket_actions do |t|
    	t.belongs_to :employee
    	t.belongs_to :rocket_action
    end
  end
end
