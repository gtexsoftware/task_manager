# frozen_string_literal: true

class InputComponent < ViewComponent::Base
  renders_one :custom_icon

  def initialize(icon: nil, label: nil, **native_attributes)
    @icon = icon
    @label = label
    @native_attributes = native_attributes
  end

  def iconized_input_class
    if @icon || custom_icon
      "iconized-input"
    end
  end
end
