class Language < ApplicationRecord
  has_many :language_blogs
  has_many :blogs, :through => :language_blogs
end
