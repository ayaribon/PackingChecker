class CreateTravelPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :travel_plans do |t|
      t.string :title, null: false
      t.string :country
      t.text :note
      t.date :due
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
 