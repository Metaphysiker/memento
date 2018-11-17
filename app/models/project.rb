class Project < ApplicationRecord

  audited

  scope :search_records_ilike, ->(search_term) { where("name ILIKE ? OR description ILIKE ?", search_term, search_term) }
end
