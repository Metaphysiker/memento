class Blog < ApplicationRecord
  audited

  belongs_to :person, optional: true
end
