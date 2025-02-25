# frozen_string_literal: true

class AvatarComponent < ViewComponent::Base
  def initialize(size: "m", type: "icon", icon: "user", icon_source: "microsoft-icons", image_source: nil, image_alt: nil, image_loading: "eager", label: nil)
    @size          = size
    @type          = type
    @icon          = icon
    @icon_source   = icon_source
    @image_alt     = image_alt
    @image_loading = image_loading
    @image_source  = image_source
    @label         = label
  end

  def icon
    @type == "icon"
  end

  def image
    @type == "image"
  end

  def first_character
    @label[0]
  end
end
