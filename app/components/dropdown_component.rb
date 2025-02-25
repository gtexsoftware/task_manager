# frozen_string_literal: true

class DropdownComponent < ViewComponent::Base
  renders_one :trigger
  renders_one :body

  def initialize(automatic_position: false, custom_class: "")
    @automatic_position = automatic_position
    @custom_class = custom_class
  end
end
