class BaseDecorator
  delegate :url_helpers, to: 'Rails.application.routes'
end