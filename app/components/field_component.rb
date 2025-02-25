# frozen_string_literal: true

class FieldComponent < ViewComponent::Base
  renders_one :field

  def initialize(label: nil, label_classes: nil, required: false, **native_attributes)
    @label = label
    @native_attributes = native_attributes
    @label_classes = label_classes
    @required = required
  end

  def full_label
    required_label = @required ? "*" : ""

    "#{@label} #{required_label}"
  end
end
