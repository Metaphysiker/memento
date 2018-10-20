class Task < ApplicationRecord

  audited

  belongs_to :taskable, polymorphic: true

end
