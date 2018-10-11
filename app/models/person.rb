class Person < ApplicationRecord
  validates :email, presence: :true, uniqueness: :true

  def self.genders
    ['male', 'female', 'transgender']
  end
end
