class ProjectPerson < ApplicationRecord
  belongs_to :person
  belongs_to :project
end
