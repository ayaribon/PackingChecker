class AddPublicToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :public, :boolean, default: false
  end
end
