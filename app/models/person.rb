class Person < ApplicationRecord
  after_create :create_address
  after_save :set_name
  audited

  has_one :address, as: :addressable

  validates :email, presence: :true, uniqueness: :true

  scope :search_people_ilike, ->(search_term) { where("people.email ILIKE ? OR people.phone ILIKE ? OR people.name ILIKE ? OR people.description ILIKE ?", search_term, search_term, search_term, search_term) }

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
end
