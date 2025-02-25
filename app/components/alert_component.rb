# frozen_string_literal: true

class AlertComponent < ViewComponent::Base
  VARIANTS = [ :success, :info, :warning, :danger, :grey ]
  ROLES    = [ :alert, :status ]

  def initialize(variant: :success, role: :alert, icon: { name: "checkmark-circle-filled" }, title: nil, closable: false)
    @variant  = variant
    @role     = role
    @icon     = icon
    @title    = title
    @closable = closable
  end

  def render?
    VARIANTS.include?(@variant) && ROLES.include?(@role)
  end
end
