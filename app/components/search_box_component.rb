# frozen_string_literal: true

class SearchBoxComponent < ViewComponent::Base
  DEFAULT_INPUT_PROPERTIES = {
    id: "search_box_input",
    name: "search_box_query",
    role: "combobox",
    autocomplete: "off",
    type: "search",
    spellcheck: false,
    "aria-expanded": false,
    "aria-haspopup": "listbox",
    "aria-controls": "search-box-results",
    "data-action": "keydown.down->search-box#startKeyNavigation focus->search-box#showResultsContainer",
    "data-search-box-target": "input"
  }.freeze

  renders_one :input, types: {
    component: lambda { |**arguments|
      InputComponent.new(value: params[:search_box_query], **arguments, **DEFAULT_INPUT_PROPERTIES)
    },
    element: lambda { |**arguments|
      text_field_tag(
        DEFAULT_INPUT_PROPERTIES[:name],
        "",
        **DEFAULT_INPUT_PROPERTIES.merge(arguments)
      )
    }
  }

  renders_one :results

  def initialize(path:, domain: "", turbo_advance: false, enter_behavior: false, wrapper_attributes: {}, auto_search: true)
    @path = path
    @domain = domain
    @turbo_advance = turbo_advance
    @wrapper_attributes = wrapper_attributes
    @enter_behavior = enter_behavior
    @auto_search = auto_search
  end

  def enter_behavior_class
    @enter_behavior ? "enter-behavior" : ""
  end

  def wrapper_classes
    "search-box #{@wrapper_attributes[:classes]} #{enter_behavior_class}"
  end

  def form_actions
    actions = "keydown.enter->search-box#handleEnterSubmit"

    actions += " input->search-box#submit" if @auto_search
    actions
  end
end
