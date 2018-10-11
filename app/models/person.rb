class Person < ApplicationRecord
  validates :email, presence: :true, uniqueness: :true
end
