class TopicRelation < ApplicationRecord
  belongs_to :person
  belongs_to :topic
end
