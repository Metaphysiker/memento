class Institution < ApplicationRecord
  after_create :create_address

  audited

  has_one :address, as: :addressable
  has_many :notes, as: :noteable
  has_many :tasks, as: :taskable

  has_many :affiliations, dependent: :destroy
  has_many :people, :through => :affiliations

  validates :name, presence: :true, uniqueness: :true

  acts_as_taggable
  acts_as_taggable_on :functionalities
  acts_as_taggable_on :target_groups

  #scope :search_institutions_ilike, ->(search_term) { joins(:people).where("people.email ILIKE ? OR people.name ILIKE ? OR institutions.name ILIKE ? OR institutions.email ILIKE ? OR institutions.description ILIKE ?", search_term, search_term, search_term, search_term, search_term) }
  #scope :search_institutions_ilike, ->(search_term) { left_outer_joins(:people).where("institutions.name ILIKE ? OR institutions.email ILIKE ? OR institutions.description ILIKE ? OR people.email ILIKE ? OR people.name ILIKE ?", search_term, search_term, search_term, search_term, search_term).distinct }
  #scope :search_institutions_ilike, ->(search_term) { left_outer_joins(:people).where("institutions.name ILIKE ? OR institutions.email ILIKE ? OR institutions.description ILIKE ?", search_term, search_term, search_term) }
  scope :search_records_ilike, ->(search_term) { left_outer_joins(:people).where("institutions.name ILIKE ? OR institutions.email ILIKE ? OR institutions.description ILIKE ? OR people.email ILIKE ? OR people.name ILIKE ?", search_term, search_term, search_term, search_term, search_term).distinct }

  INSTITUTION_ATTRIBUTES = %w{name description email phone language website}
  OTHER_ATTRIBUTES = %w{functionality target_group}
  ALL_ATTRIBUTES = INSTITUTION_ATTRIBUTES + OTHER_ATTRIBUTES + Address::ADDRESS_ATTRIBUTES

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

  def self.headers_to_csv
    CSV.generate(headers: true) do |csv|
      csv << ALL_ATTRIBUTES
    end
  end

  def self.create_or_update_institution(institution, functionality_tags, target_group_tags, address)
    institution = institution.select!{|x| Institution.attribute_names.index(x)}
    institution.delete_if {|key, value| value.blank?}

    if institution["name"].nil? || institution["name"].blank?
      return
    elsif Institution.where(email: institution["name"]).empty?
      institution = Institution.create(institution)
    else
      Institution.find_by_email(institution["name"]).update(institution)
      institution = Institution.find_by_email(institution["name"])
    end

    address = address.select!{|x| Address.attribute_names.index(x)}
    address.delete_if {|key, value| value.blank?}
    institution.address.update(address)

    unless functionality_tags.blank?
      institution.functionality_list.add(functionality_tags)
      institution.save
    end

    unless target_group_tags.blank?
      institution.target_group_list.add(target_group_tags)
      institution.save
    end

  end
end
