# frozen_string_literal: true

require "uri"

class PaginationComponent < ViewComponent::Base
  MINIMUM_OF_PAGES = 2
  PAGES_QUANTITY_TO_SHOW_LAST_PAGE = 3

  def initialize(current_page: nil, total_pages: nil, path: nil)
    @current_page = current_page
    @total_pages  = total_pages
    @path         = path
  end

  def links
    links = []

    if !show_last_page?
      @total_pages.times { |index| add_link(links, index + 1) }
    else
      if current_first_two?
        (1..3).each { |index| add_link(links, index) }
      elsif current_penultimate?
        (second_previous_page..@current_page).each { |index| add_link(links, index) }
      elsif current_last?
        (third_previous_page..previous_page).each { |index| add_link(links, index) }
      else
        (previous_page..next_page).each { |index| add_link(links, index) }
      end
    end

    links
  end

  def add_link(links, page)
    links.push(create_item(page))
  end

  def create_item(page)
    content_tag(:li, link_to(
      page,
      base_path(page),
      { 'data-turbo-action': "advance" }
    ), { class: "#{'current' if page == @current_page}" })
  end

  def create_href_attribute(page)
    "href=#{url_for(base_path(page))}"
  end

  def base_path(page)
    if @path
      uri = URI(@path)
      uri.query = URI.encode_www_form({ page: page })

      uri.to_s
    else
      request.params.merge(page: page)
    end
  end

  def next_page
    @current_page + 1
  end

  def previous_page
    @current_page - 1
  end

  def second_previous_page
    @current_page - 2
  end

  def third_previous_page
    @current_page - 3
  end

  def first_page?
    @current_page == 1
  end

  def last_page?
    @current_page == @total_pages
  end

  def show_first_page?
    show_last_page? && @current_page > PAGES_QUANTITY_TO_SHOW_LAST_PAGE
  end

  def show_last_page?
    @total_pages > PAGES_QUANTITY_TO_SHOW_LAST_PAGE
  end

  def current_penultimate?
    @current_page == (@total_pages - 1)
  end

  def current_last?
    @current_page == @total_pages
  end

  def current_first_two?
    @current_page < 3
  end

  def render?
    @total_pages >= MINIMUM_OF_PAGES
  end
end
