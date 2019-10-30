class Blog < ApplicationRecord
  audited

  after_save :add_topics_to_author

  belongs_to :person, optional: true

  has_many :topic_blogs
  has_many :topics, :through => :topic_blogs

  scope :search_records_ilike, ->(search_term) { where("working_title ILIKE ? OR description ILIKE ?", search_term, search_term) }

  def add_topics_to_author
    topics.each do |topic|
      person.topics << topic unless person.topics.exists?(topic.id)
    end
  end

end
