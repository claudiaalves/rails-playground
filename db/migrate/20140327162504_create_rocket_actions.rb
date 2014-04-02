class CreateRocketActions < ActiveRecord::Migration
  def change
    create_table :rocket_actions do |t|
      t.string :name
      t.integer :points, :default => 0

      t.timestamps
    end
  end
end
