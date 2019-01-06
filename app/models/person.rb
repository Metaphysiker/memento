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

  Address.create(
    addressable_id: self.id,
    addressable_type: Person
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

  PERSON_ATTRIBUTES = %w{form_of_address firstname lastname email phone phone2 gender language description website}
  OTHER_ATTRIBUTES = %w{institutions groups functionality target_group}
  ALL_ATTRIBUTES = PERSON_ATTRIBUTES + OTHER_ATTRIBUTES + Address::ADDRESS_ATTRIBUTES

  def self.to_csv
    #person_attributes = %w{firstname lastname email phone phone2 gender language description}
    #address_attributes = %w{firstname lastname company  company2 street plz location country }
    #human_person_attributes = person_attributes.map{ |attr| Person.human_attribute_name(attr) }
    #human_address_attributes = ["Vorname(Adresse)", "Nachname(Adresse)"] + address_attributes.drop(2).map{ |attr| Address.human_attribute_name(attr) }

    CSV.generate(headers: true) do |csv|
      csv << ALL_ATTRIBUTES

      all.each do |user|
        csv << All_ATTRIBUTES
      end

      #all.each do |user|
      #  csv << person_attributes.map{ |attr| user.send(attr) } + address_attributes.map{ |attr| user.address.send(attr) }
      #end
    end
  end

  def self.headers_to_csv
    CSV.generate(headers: true) do |csv|
      csv << ALL_ATTRIBUTES
    end
  end

  def self.example_csv
    CSV.generate(headers: true) do |csv|
      csv << ALL_ATTRIBUTES
      csv << ["Prof. Dr.", "Stefan", "Müller", "email@adresse.ch", "079123456789", "", "male", "de", "Experte in Metaphysik", "www.kant.ch",
              "1", "", "Sponsor", "",
              "Intersport AG", "", "Hagenstrasse 1", "8301", "Zürich", "CH"]
      csv << ["Dr.", "Lara", "Wagner", "email@adresse2.ch", "079123456787", "", "female", "fr", "", "www.meinewebseite.ch",
              "4 7", "4", "Veranstalter Medienkontakt", "Private Beruffachleute",
              "", "", "Rue de la gare 3", "6402", "Bern", "CH"]
      csv << ["", "Heinrich", "Keller", "email@adresse3.ch", "079123456784", "342118918", "male", "de", "", "",
              "2 3 12", "5 6", "Blogger Patronatskomitee Lehrperson", "Sponsor(Zielgruppe) Uni-Mitarbeitende Mitglieder Verein",
              "Universität Köln", "Philosophisches Seminar", "Uni-Strasse 56", "9662", "Köln", "DE"]
      csv << ["Habil. jur.", "Franz", "Schneider", "email@adresse5.ch", "078123456734", "0133258765", "male", "de", "", "www.medien.de",
              "6 7 8 9","5 6 7", "Platinmitglied", "Medienfachleute",
              "Müller GmbH", "Informatik-Abteilung", "Mozartstrasse 4", "3517", "Wien", "AT"]
      csv << ["Dr. med.", "Francesca", "Berlusconi", "email@adresse4.ch", "078123456784", "", "female", "it", "", "www.philosophie.ch",
              "12 16 21", "", "Veranstalter", "Kinder",
              "", "", "Focatia 34", "6402", "Venedig", "IT"]
    end
  end

  def self.create_or_update_person(person, institutions, groups, functionality_tags, target_group_tags, address)
    person = person.select!{|x| Person.attribute_names.index(x)}
    person.delete_if {|key, value| value.blank?}

    if person["email"].nil? || person["email"].blank?
      return
    elsif Person.where(email: person["email"]).empty?
      person = Person.create(person)
    else
      Person.find_by_email(person["email"]).update(person)
      person = Person.find_by_email(person["email"])
    end

    address = address.select!{|x| Address.attribute_names.index(x)}
    address.delete_if {|key, value| value.blank?}
    person.address.update(address)

    unless functionality_tags.blank?
      person.functionality_list.add(functionality_tags)
      person.save
    end

    unless target_group_tags.blank?
      person.target_group_list.add(target_group_tags)
      person.save
    end

    unless institutions.nil?
      institutions.each do |institution|
        person.institutions << Institution.find(institution) unless !Institution.where(id: institution).exists? || person.institutions.include?(Institution.find(institution))
      end
    end

    unless groups.nil?
      groups.each do |group|
        person.groups << Group.find(group) unless  !Group.where(id: group).exists? || person.groups.include?(Group.find(group))
      end
    end
  end

end
