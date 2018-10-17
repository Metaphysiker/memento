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

tags = ["Sponsor", "Medienkontakt","Kooperationspartner", "Stiftungsmitglied",
        "Portalmitglied", "Veranstalter", "Lehrperson", "Öffentliche Institution",
      "Blogger", "Platinmitglied", "200er-Mitglied", "Patronatskomitee"]

tags.each do |tag|
  TagList.create(
    name: tag
  )
end
