class Group < ApplicationRecord

  audited

  has_many :group_people
  has_many :groups, :through => :group_people

  scope :search_records_ilike, ->(search_term) { where("name ILIKE ? OR description ILIKE ?", search_term, search_term) }
end