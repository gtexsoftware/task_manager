module TasksHelper
  def priority_color(status)
    {
      low:    :green,
      medium: :yellow,
      high:   :red
    }[status.downcase.to_sym] || :grey
  end

  def validation_error_for(task, field)
    if task.errors.has_key?(field)
      if field == :name || field == :description || field == :custom_category || field == :org_user_id
       content_tag(:div, task.errors[field].first, class: "error")
      else
       content_tag(:div, "Please select an option", class: "error")
      end
    end
  end

  def options_for_status(decorator)
    first_option = [ "Select a Status", "", { disabled: true, selected: true } ]

    [ first_option ] + decorator.status_options
  end
end
