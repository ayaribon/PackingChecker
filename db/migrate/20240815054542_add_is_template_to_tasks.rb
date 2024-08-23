class AddIsTemplateToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :is_template, :boolean
  end
end
