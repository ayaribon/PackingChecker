class AddPublicToTravelPlans < ActiveRecord::Migration[7.2]
  def change
    add_column :travel_plans, :public, :boolean, default: false
  end
end
