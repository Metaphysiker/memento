class Note < ApplicationRecord

    audited

    belongs_to :noteable, polymorphic: true

    #scope :search_records_ilike, ->(search_term) { where("description ILIKE ?", search_term) }
    scope :search_records_ilike, ->(search_term) { where("description ILIKE ?", search_term) }

    def self.to_csv
      attributes = %w{id description}

      CSV.generate(headers: true) do |csv|
        csv << attributes

        all.each do |user|
          csv << attributes.map{ |attr| user.send(attr) }
        end
      end
    end

end
