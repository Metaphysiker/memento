class Institution < ApplicationRecord
  after_create :create_address

  audited

  has_one :address, as: :addressable
  has_many :notes, as: :noteable
  has_many :tasks, as: :taskable

  has_many :affiliations
  has_many :people, :through => :affiliations

  validates :name, presence: :true, uniqueness: :true

  acts_as_taggable
  acts_as_taggable_on :functionalities
  acts_as_taggable_on :target_groups

  #scope :search_institutions_ilike, ->(search_term) { joins(:people).where("people.email ILIKE ? OR people.name ILIKE ? OR institutions.name ILIKE ? OR institutions.email ILIKE ? OR institutions.description ILIKE ?", search_term, search_term, search_term, search_term, search_term) }
  #scope :search_institutions_ilike, ->(search_term) { left_outer_joins(:people).where("institutions.name ILIKE ? OR institutions.email ILIKE ? OR institutions.description ILIKE ? OR people.email ILIKE ? OR people.name ILIKE ?", search_term, search_term, search_term, search_term, search_term).distinct }
  #scope :search_institutions_ilike, ->(search_term) { left_outer_joins(:people).where("institutions.name ILIKE ? OR institutions.email ILIKE ? OR institutions.description ILIKE ?", search_term, search_term, search_term) }
  scope :search_records_ilike, ->(search_term) { left_outer_joins(:people).where("institutions.name ILIKE ? OR institutions.email ILIKE ? OR institutions.description ILIKE ? OR people.email ILIKE ? OR people.name ILIKE ?", search_term, search_term, search_term, search_term, search_term).distinct }

  def create_address
    Address.create(
      addressable_id: self.id,
      addressable_type: Institution,
      company: self.name,
    )
  end

  def self.to_csv
    attributes = %w{id name email description}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
end
