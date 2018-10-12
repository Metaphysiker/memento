class Person < ApplicationRecord

  audited

  validates :email, presence: :true, uniqueness: :true

  def self.genders
    ['male', 'female', 'transgender']
  end
end
