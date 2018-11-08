class Person < ApplicationRecord
  after_create :create_address
  after_save :set_name

  audited

  has_one :address, as: :addressable
  has_many :notes, as: :noteable
  has_many :tasks, as: :taskable

  has_many :affiliations
  has_many :institutions, :through => :affiliations




  validates :email, presence: :true, uniqueness: :true

  acts_as_taggable

  #scope :search_people_ilike, ->(search_term) { left_outer_joins(:institutions).where("people.email ILIKE ? OR people.phone ILIKE ? OR people.name ILIKE ? OR people.description ILIKE ? OR institutions.name ILIKE ?", search_term, search_term, search_term, search_term, search_term) }
  scope :search_records_ilike, ->(search_term) { left_outer_joins(:institutions).where("people.email ILIKE ? OR people.phone ILIKE ? OR people.name ILIKE ? OR people.description ILIKE ? OR institutions.name ILIKE ?", search_term, search_term, search_term, search_term, search_term) }

  def create_address

    form_of_address = ""

    if self.gender == "male"
      form_of_address = "Herr"
    elsif self.gender == "female"
      form_of_address = "Frau"
    end

  Address.create(
    addressable_id: self.id,
    addressable_type: Person,
    firstname: self.firstname,
    lastname: self.lastname,
    form_of_address: form_of_address
  )
end

  def self.genders
    ['male', 'female', 'transgender']
  end

  def set_name
    name = ""

    if self.firstname.blank? || self.lastname.blank?
      name = self.email.split("@").first
    else
      name = "#{self.firstname} #{self.lastname}"
    end

    self.update_column(:name, name)
  end

  def self.to_csv
    person_attributes = %w{firstname lastname email phone gender description}
    human_person_attributes = person_attributes.map{ |attr| Person.human_attribute_name(attr) }
    address_attributes = %w{firstname lastname company street plz location country }
    human_address_attributes = ["Vorname(Adresse)", "Nachname(Adresse)"] + address_attributes.drop(2).map{ |attr| Address.human_attribute_name(attr) }

    CSV.generate(headers: true) do |csv|
      csv << human_person_attributes + human_address_attributes

      all.each do |user|
        csv << person_attributes.map{ |attr| user.send(attr) } + address_attributes.map{ |attr| user.address.send(attr) }
      end
    end
  end
end
