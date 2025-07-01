require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  fixtures :orgs, :employees, :tasks

  setup do
    @org = orgs(:casa_montanha)
    @employee = employees(:humberto)
    @task = tasks(:needs_to_be_done)
    @task_params = {
      name: "New Task",
      description: "Task Description",
      due_date: Date.today,
      priority: "high",
      status: "blocked",
      employee_id: @employee.id,
      org_id: @org.id
    }
  end

  test "should get new" do
    get new_task_url
    assert_response :success
  end

  test "should create task" do
    assert_difference("Task.count") do
      post tasks_path, params: { task: @task_params }
    end

    assert_redirected_to tasks_url
    follow_redirect!
  end

  test "should get edit" do
    task = Task.create!(name: "Edit Task", org: @org, description: "Desc", due_date: Date.today, priority: "high", status: "blocked", employee: @employee )
    get edit_task_url(task)
    assert_response :success
  end
end
