class Institution < ApplicationRecord
  after_create :create_address

  audited

  has_one :address, as: :addressable

  has_many :affiliations
  has_many :people, :through => :affiliations

  validates :name, presence: :true, uniqueness: :true

  acts_as_taggable

  #scope :search_institutions_ilike, ->(search_term) { joins(:people).where("people.email ILIKE ? OR people.name ILIKE ? OR institutions.name ILIKE ? OR institutions.email ILIKE ? OR institutions.description ILIKE ?", search_term, search_term, search_term, search_term, search_term) }
  #scope :search_institutions_ilike, ->(search_term) { left_outer_joins(:people).where("institutions.name ILIKE ? OR institutions.email ILIKE ? OR institutions.description ILIKE ? OR people.email ILIKE ? OR people.name ILIKE ?", search_term, search_term, search_term, search_term, search_term) }
  scope :search_institutions_ilike, ->(search_term) { left_outer_joins(:people).where("institutions.name ILIKE ? OR institutions.email ILIKE ? OR institutions.description ILIKE ?", search_term, search_term, search_term) }

  def create_address
    Address.create(
      addressable_id: self.id,
      addressable_type: Institution,
      company: self.name,
    )
  end
end
