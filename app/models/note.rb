class Note < ApplicationRecord

    audited

    #scope :search_records_ilike, ->(search_term) { where("description ILIKE ?", search_term) }
    scope :search_records_ilike, ->(search_term) { where("description ILIKE ?", search_term) }
end
