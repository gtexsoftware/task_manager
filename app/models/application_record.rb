class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.humanized_enum(enum, type)
    I18n.t(".tasks.#{enum}.#{type}")
  end
end
