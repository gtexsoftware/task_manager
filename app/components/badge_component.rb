# frozen_string_literal: true

class BadgeComponent < ViewComponent::Base
  SIZES          = [ :s, :l ]
  COLORS         = [ :grey, :red, :yellow, :green, :blue, :purple, :magenta, :orange ]
  ICON_POSITIONS = [ :leading, :trailing ]

  DEFAULT_SIZE          = :s
  DEFAULT_COLOR         = :green
  DEFAULT_ICON_POSITION = :leading

  def initialize(size: DEFAULT_SIZE, color: DEFAULT_COLOR, icon: nil, icon_position: DEFAULT_ICON_POSITION)
    @size          = size
    @color         = color
    @icon          = icon
    @icon_position = icon_position
  end

  def classes
    "badge #{@size} #{@icon_position.to_s if @icon}"
  end

  def style
    <<-TEXT
      --db-component-badge-bg-color: var(--db-color-#{@color}-100);
      --db-component-badge-text-color: var(--db-color-#{@color}-800);
    TEXT
  end

  def icon
    render(IconComponent.new(name: @icon, source: "microsoft-icons")) if @icon
  end

  def render?
    SIZES.include?(@size) && COLORS.include?(@color) && content.present?
  end
end
