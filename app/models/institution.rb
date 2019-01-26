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

  INSTITUTION_ATTRIBUTES = %w{name description email phone website language}
  TAG_ATTRIBUTES = %w{functionality target_group}
  INSTITUTION_ATTRIBUTES_WITH_TAGS = INSTITUTION_ATTRIBUTES + %w{functionality_list target_group_list}

  def create_address
    Address.create(
      addressable_id: self.id,
      addressable_type: Institution,
      line1: self.name,
    )
  end

  def self.to_csv

    CSV.generate(headers: true) do |csv|
      csv << INSTITUTION_ATTRIBUTES_WITH_TAGS + Address::ADDRESS_ATTRIBUTES

      all.each do |user|
        csv << INSTITUTION_ATTRIBUTES_WITH_TAGS.map{ |attr| user.send(attr) } + Address::ADDRESS_ATTRIBUTES.map{ |attr| user.address.send(attr) }
      end
    end
  end

  def self.headers_to_csv
    CSV.generate(headers: true) do |csv|
      csv << INSTITUTION_ATTRIBUTES + TAG_ATTRIBUTES + Address::ADDRESS_ATTRIBUTES
    end
  end

  def self.example_csv
    CSV.generate(headers: true) do |csv|
      csv << INSTITUTION_ATTRIBUTES + TAG_ATTRIBUTES + Address::ADDRESS_ATTRIBUTES
      csv << ["Universität Bern",
              "Das Philosophische Institut der Universität Bern ist das zweitgrösste philosophische Institut der Schweiz.",
              "unibe@unibe.ch",
              "079123477789",
              "www.unibe.ch",
              "de",
              "Philosophische-Institution Öffentliche-Institution",
              "Kooperationspartner(Zielgruppe) SBFI/swissuniversities",
              "Fachabteilung Philosophie", "Uni Tobler", "Bereich Geisteswissenschaften", "Sekretariat", "Lara Ullmer", "Lerchenweg 36", "3001", "Bern", "CH"]

    end
  end

  def self.create_or_update_institution(institution, functionality_tags, target_group_tags, address)
    institution = institution.select!{|x| Institution.attribute_names.index(x)}
    institution.delete_if {|key, value| value.blank?}

    if institution["name"].nil? || institution["name"].blank?
      return
    elsif Institution.where(name: institution["name"]).empty?
      institution = Institution.create(institution)
    else
      Institution.find_by_name(institution["name"]).update(institution)
      institution = Institution.find_by_name(institution["name"])
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
