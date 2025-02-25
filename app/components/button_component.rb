# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  VARIANTS = [ :primary, :secondary, :tertiary, :critical ]
  SIZES    = [ :s, :m, :l ]

  def initialize(variant: :primary, size: :m, icon: {}, icon_only: false, loading: false, disabled: false, **native_attributes)
    @variant            = variant
    @size               = size
    @icon               = icon
    @icon_only          = icon_only
    @loading            = loading
    @disabled           = disabled
    @native_attributes  = native_attributes
  end

  def icon_position
    @icon[:position] || "leading" if icon_svg
  end

  def icon_svg
    render IconComponent.new(name: @icon[:name], source: "microsoft-icons") if @icon[:name]
  end

  def icon_classes
    icon_class = "iconized" if icon_svg
    only_icon_class = "only-icon" if @icon_only

    "#{icon_class} #{only_icon_class} #{icon_position}"
  end

  def loading_icon
    render IconComponent.new(name: "spinner-ios", source: "microsoft-icons") if @loading
  end

  def component_content
    if @loading
      loading_icon
    elsif icon_svg && !@icon_only
      button_content = content + icon_svg

      button_content.html_safe
    elsif @icon_only
      icon_svg
    else
      content
    end
  end

  def component_tag
    @native_attributes[:href].present? ? :a : :button
  end

  def disabled?
    @disabled || @loading
  end

  def loading_class
    "loading" if @loading
  end

  def classes
    "btn #{@variant} size-#{@size} #{icon_classes} #{loading_class}"
  end

  def call
    content_tag component_tag, component_content, { class: classes, disabled: disabled?, **@native_attributes  }
  end

  def render?
    VARIANTS.include?(@variant) && SIZES.include?(@size)
  end
end
