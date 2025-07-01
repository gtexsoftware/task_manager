class TasksController < ApplicationController
  LIMIT_PER_PAGE = 50.freeze

  include ActionView::RecordIdentifier

  before_action :set_tasks, only: %i[index destroy]
  before_action :set_task,  only: %i[update destroy]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "You've successfully created the task."
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
    @task_decorator = TaskDecorator.new(@task)

    render turbo_stream: [
      turbo_stream.replace(
        "show_task",
        partial: "tasks/show/task",
        locals: { task: @task }
      )
    ]
  end

  def edit
    @task = Task.find(params[:id])
    @task_decorator = TaskDecorator.new(@task)
  end

  def update
    if @task.update(task_params)
      handle_success_message
    else
      flash.now[:alert] = "Failed to update task, please select all options."
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash.now[:notice] = "You've successfully deleted the task."
    render turbo_stream: [
      turbo_stream.update(
        "task_list",
        partial: "tasks/index/task_list",
        locals: { tasks: @tasks }
      ),
      turbo_stream.update("flash", partial: "layouts/flash")
    ]
  end

  def tasks_employee_autocomplete
    render partial: "tasks/form/employee_search_box_results", locals: {
      employess: filtered_employees
    }
  end

  private

  MAX_QUANTITY_OF_RESULTS = 5
  def filtered_employees
    return if params[:search_box_query].blank?

    @filtered_employees = Org.last
                          .employees
                          .by_full_name(params[:search_box_query])
                          .by_email(params[:email])
                          .first(MAX_QUANTITY_OF_RESULTS)
  end

  def task_params
    params.require(:task)
      .permit(
        :name, :description, :due_date, :priority, :status, :employee_id
      ).merge(org_id: Org.last.id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_tasks
    @tasks = Task.all
      .paginate(page: page, per_page: LIMIT_PER_PAGE, total_entries: count)
  end

  def page
    [ params[:page].to_i, 1 ].max
  end

  def count
    Task.count
  end

  def handle_success_message
    message = "You've successfully updated the task."

    if params[:action] = "update"
      redirect_to tasks_path, notice: message
    else
      flash.now[:notice] = message
      render turbo_stream: [
        turbo_stream.replace(
          dom_id(@task),
          partial: "tasks/index/task",
          locals: { task: @task }
        ),
        turbo_stream.update("flash", partial: "layouts/flash")
      ]
    end
  end
end
