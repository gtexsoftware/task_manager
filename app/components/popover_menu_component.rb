# frozen_string_literal: true

class PopoverMenuComponent < ViewComponent::Base
  renders_one  :list, "ListComponent"
  renders_many :items, "ItemComponent"

  class ListComponent < ViewComponent::Base
    attr_reader :classes, :attributes

    def initialize(classes: "", attributes: {})
      @classes = classes
      @attributes = attributes
    end

    def call
      content_tag :ul, content, { class: "popover-list " + classes, **attributes }
    end
  end

  class ItemComponent < ViewComponent::Base
    attr_reader :classes, :attributes

    def initialize(classes: "", attributes: {})
      @classes = classes
      @attributes = attributes
    end

    def call
      content_tag :li, content, { class: "popover-item " + classes, **attributes }
    end
  end
end
