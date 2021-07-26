class WorkTime < ApplicationRecord
  require 'csv'

  belongs_to :user

  def self.areas
    [
      "Institute",
      "Entwicklung Inhalt (Blogs)",
      "Entwicklung Verein",
      "Entwicklung Netzwerk",
      "Festival",
      "Mitgliedschaft",
      "Basisbetrieb Inhalt",
      "Basisbetrieb Netzwerk",
      "Basisbetrieb Technik",
      "Fundraising",
      "Rechnungswesen",
      "overhead",
      #"Interviews",
      #{}"Fachferne",
      #{}"Blog affin (forschungsprojekte, volksabstimmungen, aktivitäten)",
      "Memento",
      #{}"SPG Technik",
      #{}"Essays Geschichte",
      #{}"Lernspiel",
      "Vorstand",
      "Events",
      #{}"Kurse",
      "Produkte",
      "Philexpo22",
      "Team-Meeting",
      "Networking",
      "Akquise"
      #{}"webmastering"
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

  def self.to_csv(user)

    worktime_attributes = %w{user_id date time task area project voluntary}

    #person_attributes = %w{firstname lastname email phone phone2 gender language description}
    #human_person_attributes = person_attributes.map{ |attr| Person.human_attribute_name(attr) }
    #human_address_attributes = ["Vorname(Adresse)", "Nachname(Adresse)"] + address_attributes.drop(2).map{ |attr| Address.human_attribute_name(attr) }

    user_id = user.id

    CSV.generate(headers: true) do |csv|
      csv << worktime_attributes

      WorkTime.where(user_id: user_id).order(:date).each do |work_time|
        csv << worktime_attributes.map{ |attr| work_time.send(attr) }
      end

      #all.each do |user|
      #  csv << person_attributes.map{ |attr| user.send(attr) } + address_attributes.map{ |attr| user.address.send(attr) }
      #end
    end
  end

end
