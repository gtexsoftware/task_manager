# frozen_string_literal: true

class SearchBoxResultsComponent < ViewComponent::Base
  renders_many :options, "SearchBoxResultsItemComponent"

  def initialize(turbo_frame_name: "", button_attributes: "")
    @turbo_frame_name = turbo_frame_name
  end

  class SearchBoxResultsItemComponent < ViewComponent::Base
    def initialize(**attributes)
      @attributes = attributes
    end

    def component_tag
      @attributes[:href].nil? ? :button : :a
    end

    def trigger_attributes
      @attributes[:trigger_attributes]? @attributes[:trigger_attributes] : {}
    end

    def call
      content_tag(
        :li,
        content_tag(component_tag, content, {
          href: @attributes[:href],
          **trigger_attributes,
          'data-turbo': false,
          class: "search-box-trigger"
        }),
        role: "option",
        'tab-index': -1,
        'data-action': "keydown.down->search-box#keyNavigation keydown.up->search-box#keyNavigation"
      )
    end
  end
end
