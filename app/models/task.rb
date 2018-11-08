class Task < ApplicationRecord

  audited

  belongs_to :taskable, polymorphic: true

  scope :search_records_ilike, ->(search_term) { where("description ILIKE ? OR status ILIKE ?", search_term, search_term) }

  def self.statuses
    ['noch nicht angefangen', 'angefangen', 'bald abgeschlossen', 'abgeschlossen']
  end

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
