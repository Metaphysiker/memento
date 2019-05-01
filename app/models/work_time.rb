class WorkTime < ApplicationRecord
  belongs_to :user

  def self.areas
    [
      "Basisbetrieb Inhalt",
      "Basisbetrieb Netzwerk",
      "Basisbetrieb Technik",
      "Fundraising",
      "Rechnungswesen",
      "overhead",
      "Interviews",
      "Fachferne",
      "Blog affin (forschungsprojekte, volksabstimmungen, aktivitäten)",
      "Memento",
      "SPG Technik",
      "Essays Geschichte",
      "Lernspiel",
      "Vorstand",
      "Events",
      "Kurse",
      "Produkte",
      "webmastering"
    ]
  end

  def self.projects
    [
    "Hummel",
    "Verein",
    "SPG",
    "UBS",
    "Göhner"
    ]
  end
end
