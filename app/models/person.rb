class Person < ApplicationRecord
  after_save :set_name
  audited

  validates :email, presence: :true, uniqueness: :true

  scope :search_people_ilike, ->(search_term) { where("people.email ILIKE ? OR people.phone ILIKE ? OR people.name ILIKE ? OR people.description ILIKE ?", search_term, search_term, search_term, search_term) }

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
