# frozen_string_literal: true

class BaseComponent < ViewComponent::Base
  SELF_CLOSING_TAGS = [ :area, :base, :br, :col, :embed, :hr, :img, :input, :link, :meta, :param, :source, :track, :wbr ].freeze

  def initialize(tag:, classes: nil, **native_attributes)
    @tag = tag

    @native_attributes = native_attributes.merge(class: classes)
  end

  def call
    if SELF_CLOSING_TAGS.include?(@tag)
      tag(@tag, @native_attributes)
    else
      content_tag(@tag, content, **@native_attributes)
    end
  end
end
