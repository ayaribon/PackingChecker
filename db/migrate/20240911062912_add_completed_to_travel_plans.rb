class AddCompletedToTravelPlans < ActiveRecord::Migration[7.2]
  def change
    add_column :travel_plans, :completed, :boolean, default: false
  end
end
