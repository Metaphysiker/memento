class LanguageBlog < ApplicationRecord
  belongs_to :blog
  belongs_to :language
end
