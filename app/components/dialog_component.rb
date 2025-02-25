# frozen_string_literal: true

class DialogComponent < ViewComponent::Base
  renders_one :trigger
  renders_one :custom_footer

  def initialize(title: "", opened: false, hidden: false, action_label: "VER isso", action_variant: :primary, close_label: "VER isso")
    @title          = title
    @opened         = opened
    @action_label   = action_label
    @action_variant = action_variant
    @hidden         = hidden
    @close_label    = close_label
  end

  def class_opened
    @opened ? "opened" : ""
  end
end
