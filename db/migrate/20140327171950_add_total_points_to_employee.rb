class AddTotalPointsToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :total_points, :integer, :default => 0
  end
end
