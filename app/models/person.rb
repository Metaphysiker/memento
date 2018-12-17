class Person < ApplicationRecord
  after_create :create_address
  after_create :set_gender
  after_save :set_name

  audited

  has_one :address, as: :addressable
  has_many :notes, as: :noteable
  has_many :tasks, as: :taskable

  has_many :affiliations, dependent: :destroy
  has_many :institutions, :through => :affiliations

  has_many :project_people
  has_many :projects, :through => :project_people

  has_many :group_people
  has_many :groups, :through => :group_people

  validates :email, presence: :true, uniqueness: :true

  acts_as_taggable
  acts_as_taggable_on :functionalities
  acts_as_taggable_on :target_groups

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

  def set_gender
    if self.gender.blank? && !self.firstname.blank?

      gender = Guess.gender(self.firstname)[:gender]
      self.update_column(:gender, gender)
    end
  end

  def self.to_csv
    person_attributes = %w{firstname lastname email phone gender language description}
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

  def self.headers_to_csv
    person_attributes = %w{firstname lastname email phone gender language description}
    #human_person_attributes = person_attributes.map{ |attr| Person.human_attribute_name(attr) }
    address_attributes = %w{firstname lastname company street plz location country }
    #human_address_attributes = ["Vorname(Adresse)", "Nachname(Adresse)"] + address_attributes.drop(2).map{ |attr| Address.human_attribute_name(attr) }

    CSV.generate(headers: true) do |csv|
      csv << person_attributes + address_attributes
    end
  end

  def self.create_or_update_person(person, functionality_tags, target_group_tags, institutions)
    person = person.select!{|x| Person.attribute_names.index(x)}
    puts person["email"]
    if person["email"].nil? || person["email"].blank?
      return
    elsif Person.where(email: person["email"]).empty?
      person = Person.create(person)
    else
      Person.find_by_email(person["email"]).update(person)
      person = Person.find_by_email(person["email"])
    end

    unless functionality_tags.blank?
      puts functionality_tags.inspect
      person.functionality_list.add(functionality_tags)
      person.save
    end

    unless target_group_tags.blank?
      puts target_group_tags.inspect
      person.target_group_list.add(target_group_tags)
      person.save
    end

    unless institutions.nil?
      institutions.each do |institution|
        person.institutions << Institution.find(institution)
      end
    end
  end

end
