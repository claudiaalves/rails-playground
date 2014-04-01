class CreateEmployeeRocketActionAssociations < ActiveRecord::Migration
  def change
    create_table :employee_rocket_action_associations do |t|
      t.belongs_to :employee
      t.belongs_to :rocket_action
      t.timestamps
    end
  end
end
