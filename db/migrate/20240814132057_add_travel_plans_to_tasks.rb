class AddTravelPlansToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :travel_plan, foreign_key: true
  end
end
