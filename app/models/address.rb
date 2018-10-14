class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  audited
end
