class AddTemplateToTravelPlans < ActiveRecord::Migration[7.2]
  def change
    add_column :travel_plans, :is_template, :boolean, default: false, null: false
  end
end
