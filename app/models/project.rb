class Project < ApplicationRecord

  audited

  has_many :project_people
  has_many :people, :through => :project_people

  scope :search_records_ilike, ->(search_term) { where("name ILIKE ? OR description ILIKE ?", search_term, search_term) }
end
