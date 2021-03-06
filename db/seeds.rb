# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
    username: "Sandro",
    email: "sandro.raess@philosophie.ch",
    role: "admin",
    password: 123456
)

User.create(
    username: "Anja",
    email: "anja.leser@philosophie.ch",
    role: "admin",
    password: 123456
)

User.create(
    username: "Sahra",
    email: "sahra.styger@philosophie.ch",
    role: "admin",
    password: 123456
)

User.create(
    username: "Benjamin",
    email: "benjamin.ilg@philosophie.ch",
    role: "admin",
    password: 123456
)

person_functionality_tags = ["Sponsor", "Medienkontakt","Kooperationspartner",
                              "Stiftungsmitglied", "Portalmitglied", "Veranstalter",
                              "Lehrperson",
                              "Blogger", "Platinmitglied", "200er-Mitglied",
                              "Patronatskomitee", "Podiumsgast/Events"]

person_target_groups_tags = ["Kinder", "Schüler","Studierende", "Sponsor(Zielgruppe)",
                              "Uni-Mitarbeitende", "Gymnasiallehrperson",
                              "Private", "Beruffachleute", "Medienfachleute",
                              "Vereinsmitglied", "Blogger(Zielgruppe)"]

institutions_functionality_tags = ["Sponsor", "Medienkontakt","Kooperationspartner",
                                    "Stiftung", "Veranstalter", "Lehrperson",
                                    "Öffentliche-Institution", "Philosophische-Institution", "Platinmitglied",
                                    "200er-Mitglied", "Patronatskomitee", "Portalmitglied", "Gymnasium",
                                  "Universität"]

institutions_target_groups_tags = ["Sponsor(Zielgruppe)", "Medienkontakt(Zielgruppe)", "Kooperationspartner(Zielgruppe)",
                                    "Stiftung(Zielgruppe)", "SBFI/swissuniversities",
                                    "Philosophische-Institution(Zielgruppe)","SPG/SAGW",
                                    "Charles-Hummel-Stiftung", "Philosophischer-Verein",
                                    "Verlag", "Verein", "Öffentliche-Institution(Zielgruppe)", "Gymnasium(Zielgruppe)",
                                    "Unternehmen", "Philosophisches-Cafe(Zielgruppe)", "Philosophische-Praxis(Zielgruppe)"]

person_functionality_tags.each do |tag|
  TagList.create(
    name: tag,
    category: "functionality",
    model: "Person"
  )
end

person_target_groups_tags.each do |tag|
  TagList.create(
    name: tag,
    category: "target_group",
    model: "Person"
  )
end

institutions_functionality_tags.each do |tag|
  TagList.create(
    name: tag,
    category: "functionality",
    model: "Institution"
  )
end

institutions_target_groups_tags.each do |tag|
  TagList.create(
    name: tag,
    category: "target_group",
    model: "Institution"
  )
end

topics = ["Angewandte Ethik", "Politische Philosophie", "Sozialphilosophie", "Theoretische Ethik", "Kulturphilosophie", "Religionsphilosophie",
          "Rechtsphilosophie", "Metaphysik", "Erkenntnistheorie", "Feministische Philosophie", "Geschichtsphilosophie", "Logik", "Ideengeschichte", "Philosophie der Sozial- und Geisteswissenschaften", "Wissenschaftsphilosophie",
          "Philosophie des Geistes", "Sprachphilosophie", "Hermeneutik", "Phänomenologie", "Existentialismus", "Philosophische Anthropologie",
          "Ästhetik",
          "Philosophie der Antike", "Philosophie des Mittelalters", "Philosophie der Moderne", "Kant", "Transzedentalphilosophie", "Wittgenstein"
        ]

topics.each do |topic|
  Topic.create(name: topic)
end

#rails db:drop && rails db:create && rails db:migrate && rails db:seed && rake sync:totalsync
