module Employee::SearchFilter
  extend ActiveSupport::Concern

  included do
    scope :by_full_name, ->(q) {
      return current_scope if q.blank?

      where("CONCAT_WS(' ', first_name, last_name) ILIKE ?", "%#{q}%")
    }

    scope :by_email, ->(q) {
      return current_scope if q.blank?

      where("email ILIKE ?", "%#{q}%")
    }
  end
end
