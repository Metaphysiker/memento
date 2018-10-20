class Task < ApplicationRecord

  audited

  belongs_to :taskable, polymorphic: true

  def self.statuses
    ['noch nicht angefangen', 'angefangen', 'bald abgeschlossen', 'abgeschlossen']
  end

end
