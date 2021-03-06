class Group < ApplicationRecord

  audited

  has_many :group_people
  has_many :people, :through => :group_people

  has_many :project_groups
  has_many :projects, :through => :project_groups

  scope :search_records_ilike, ->(search_term) { where("name ILIKE ? OR description ILIKE ?", search_term, search_term) }
end
