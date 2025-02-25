# frozen_string_literal: true

class TabNavigationComponent < ViewComponent::Base
  renders_one :tab_content
  renders_one :right_tabs_actions

  def initialize(tabs, actived_tab)
    @tabs = tabs
    @actived_tab = actived_tab.to_sym
  end

  def actived_tab_class(tab)
    'actived' if @actived_tab == tab[:name]
  end
end