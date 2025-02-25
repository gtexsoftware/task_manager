class AddPriorityToTasks < ActiveRecord::Migration[8.0]
  def change
    create_enum :tasks_priority_options, ["low", "medium", "high"]
    add_column :tasks, :priority, :enum, null: false, enum_type: 'tasks_priority_options'
  end
end
