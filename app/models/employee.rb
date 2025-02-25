class Employee < ApplicationRecord
  include Employee::SearchFilter

  belongs_to :org
  has_many :tasks
end
