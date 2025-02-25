# frozen_string_literal: true

class DropdownPopoverComponent < ViewComponent::Base
  renders_one :trigger
  renders_many :items

  def initialize(automatic_position: true)
    @automatic_position = automatic_position
  end
end
