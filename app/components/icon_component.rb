# frozen_string_literal: true

class IconComponent < ViewComponent::Base
  def initialize(name: nil, source: nil)
    @name = name
    @source = source
  end
  
  def path
    return "#{@source}/" if @source.present?
  end
end