class Task < ApplicationRecord
  belongs_to :org
  belongs_to :employee

  enum :priority, { low: "low", medium: "medium", high: "high" }

  enum :status, { not_started: "not_started", in_progress: "in_progress", completed: "completed", blocked: "blocked" }

  def priority_label
    I18n.t("task.priorities.#{priority}", default: priority.humanize)
  end

  def status_label
    I18n.t("task.statuses.#{status}", default: status.humanize)
  end
end
