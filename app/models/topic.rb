class Topic < ApplicationRecord
  has_many :topic_relations
  has_many :people, :through => :topic_relations

  has_many :topic_blogs
  has_many :blogs, :through => :topic_blogs
end
