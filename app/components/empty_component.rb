# frozen_string_literal: true

class EmptyComponent < ViewComponent::Base
  renders_one :actions

  attr_reader :title, :subtitle, :image_path, :image_alt, :icon

  def initialize(title: nil, subtitle: nil, image_path: nil, image_alt: nil, icon: nil)
    @title      = title
    @subtitle   = subtitle
    @image_path = image_path
    @image_alt  = image_alt
    @icon  = icon
  end
end