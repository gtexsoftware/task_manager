# frozen_string_literal: true

class TableComponent < ViewComponent::Base
  renders_many :rows
  renders_many :expansible_contents

  def before_render
    @columns.each_with_index do |column, index|
      if has_sort_param
        if sorted_column === column[:id]
          @sorted_index = index
          @current_direction = sorted_order
        end
      end
    end
  end

  def initialize(columns:, data: nil, sortable: false, check_all: false, decorator: nil, decorator_params: {}, empty_params: { title: 'No data found' })
    @columns          = columns
    @data             = data
    @check_all        = check_all
    @sortable         = sortable
    @decorator        = decorator
    @decorator_params = decorator_params
    @empty_params     = empty_params
  end

  def sort_link(column:, label:, column_index:)
    direction = next_direction.empty? ? "" : next_direction

    return "" unless column.present?

    if !selected_column?(column_index: column_index)
      sort_params = { sort: "#{column} asc" }
    elsif direction.empty?
      sort_params = { sort: nil }
    else
      sort_params = { sort: "#{column} #{direction}" }
    end

    link_to(safe_join([label, sort_icons(column_index)]), url_for(request.params.merge(sort_params).except("page")), 'data-turbo-action': "advance")
  end

  def sort_icons(index)
    up_icon = render(IconComponent.new(name: 'chevron-up', source: 'microsoft-icons'))
    down_icon = render(IconComponent.new(name: 'chevron-down', source: 'microsoft-icons'))

    content_tag :div, class: "sorting-arrow #{@current_direction} #{selected_column_class(column_index: index)}" do
      safe_join([up_icon, down_icon])
    end
  end

  def next_direction
    if has_sort_param
      sorted_order == "asc" ? "desc" : ""
    else
      return "asc"
    end
  end

  def selected_column?(column_index:)
    @sorted_index == column_index
  end

  def selected_column_class(column_index:)
    if selected_column?(column_index: column_index)
      "sorting"
    end
  end

  def has_decorator()
    !@decorator.nil?
  end

  def row_html(row_content:)
    row_data = has_decorator ? @decorator.new(row_content, **@decorator_params) : row_content

    content_tag :tr, row_content(row: row_data)
  end

  def row_content(row:)
    content = ""

    @columns.each_with_index do |column, index|
      content += content_tag(:td, cel_content(column: column, row: row), { class: selected_column_class(column_index: index) })
    end

    sanitize(content, tags: %w(td a br span strong summary details ul li div blockquote), :attributes => %w(data-turbo href class))
  end

  def cel_content(column:, row:)
    content = has_decorator ? row.public_send(column[:id].to_sym) : row[column[:id].to_sym]

    content
  end

  private

  def has_sort_param
    params.has_key?(:sort)
  end

  def sorted_column
    params[:sort].split[0]
  end

  def sorted_order
    params[:sort].split[1]
  end
end