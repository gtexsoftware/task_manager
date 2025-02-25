class AddStatusToTasks < ActiveRecord::Migration[8.0]
  def change
    create_enum :tasks_status_options, ["not_started", "in_progress", "completed", "blocked"]
    add_column :tasks, :status, :enum, null: false, enum_type: 'tasks_status_options'
  end
end
