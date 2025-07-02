include ActionView::Helpers::UrlHelper

class TaskDecorator < BaseDecorator
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def id
    task.id
  end

  def due_date
    task.due_date
  end

  def due_date_label
    task.due_date.present? ? task.due_date.strftime("%B %d, %Y") : I18n.t("no_due_date")
  end

  def name
    task.name
  end

  def description
    task.description
  end

  # def category_options
  #   Task.categories.map { |key, _value| [ Task.humanized_enum("categories", key), key ] }
  # end

  # def category
  #   task.category == "other" ? task.custom_category : task.category_label
  # end

  # def purpose_options
  #   Task.purposes.map { |key, _value| [ Task.humanized_enum("purposes", key), key ] }
  # end

  # def purpose
  #   task.purpose_label
  # end

  # def category_and_purpose
  #   return task.custom_category if task.category == 'other'

  #   "#{task.category&.titleize} - #{task.purpose&.titleize}"
  # end

  def status_options
    Task.statuses.map { |key, _value| [ Task.statuses, key ] }
  end

  def status
    task.status.present? ? task.status_label : Task.statuses[:not_started].titleize
  end

  def priority_options
    Task.priorities.map { |key, _value| [ Task.priorities, key ] }
  end

  def priority
    task.priority.present? ? task.priority_label : Task.priorities[:low].titleize
  end

  def employee
    task.employee
  end

  private

  def preferred_date_format
    task.org.preferred_date_format
  end
end
