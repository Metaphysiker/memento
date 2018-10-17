class Institution < ApplicationRecord

  has_one :address, as: :addressable

  has_many :affiliations
  has_many :people, :through => :affiliations

  validates :name, presence: :true, uniqueness: :true
end
