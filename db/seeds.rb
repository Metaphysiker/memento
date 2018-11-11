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

person_functionality_tags = ["Sponsor", "Medienkontakt","Kooperationspartner", "Stiftungsmitglied",
        "Portalmitglied", "Veranstalter", "Lehrperson", "Öffentliche Institution",
      "Blogger", "Platinmitglied", "200er-Mitglied", "Patronatskomitee"]

person_functionality_tags.each do |tag|
  TagList.create(
    name: tag,
    category: "functionality",
    model: "Person"
  )
end

person_target_groups_tags = ["Kinder", "Schüler","Studierende", "Uni-Mitarbeitende",
        "Gymnasiallehrperson", "Private", "Beruffachleute", "Medienfachleute",
      "Mitglieder Verein", "ehrenamtliche Blogger"]

person_target_groups_tags.each do |tag|
  TagList.create(
    name: tag,
    category: "target_group",
    model: "Person"
  )
end

institutions_functionality_tags = ["Sponsor", "Medienkontakt","Kooperationspartner", "Stiftungsmitglied",
        "Portalmitglied", "Veranstalter", "Lehrperson", "Öffentliche Institution",
      "Blogger", "Platinmitglied", "200er-Mitglied", "Patronatskomitee"]

institutions_functionality_tags.each do |tag|
  TagList.create(
    name: tag,
    category: "functionality",
    model: "Institution"
  )
end

institutions_target_groups_tags = ["Philosophisches Institut", "Kooperationspartner","SPG/SAGW", "Charles Hummel Stiftung",
        "Stiftung", "Philosophischer Verein", "Verlag", "Sponsor",
      "Verein", "öffentliche Institution", "Unternehmen", "Medienkontakt"]

institutions_target_groups_tags.each do |tag|
  TagList.create(
    name: tag,
    category: "target_group",
    model: "Institution"
  )
end

#rails db:create && rails db:migrate && rails db:seed && rake sync:totalsync
