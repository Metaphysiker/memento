class Blog < ApplicationRecord
  audited

  belongs_to :person, optional: true

  scope :search_records_ilike, ->(search_term) { where("working_title ILIKE ? OR description ILIKE ?", search_term, search_term) }

end
