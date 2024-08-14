class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :body
      t.date :due
      t.string :status, null: false, default: :pending
      t.string :baggage, null: false, default: :carry
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
