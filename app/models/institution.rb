class Institution < ApplicationRecord
  after_create :create_address

  audited

  has_one :address, as: :addressable

  has_many :affiliations
  has_many :people, :through => :affiliations

  validates :name, presence: :true, uniqueness: :true


  def create_address

    Address.create(
      addressable_id: self.id,
      addressable_type: Institution,
      company: self.name,
    )
  end
end
