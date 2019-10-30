class Topic < ApplicationRecord
  has_many :topic_relations
  has_many :people, :through => :topic_relations
end
