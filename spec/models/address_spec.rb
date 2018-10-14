require 'rails_helper'

RSpec.describe Address, type: :model do

  it "is valid with email" do
    person = Person.new(email: Faker::Internet.email)

    expect(person).to be_valid

    company = Faker::Address.community
    street = Faker::Address.street_address
    plz = Faker::Address.zip_code
    location = Faker::Address.city
    country = Faker::Address.country

    address = Address.create(
      form_of_address: "Herr",
      firstname: person.firstname,
      lastname: person.lastname,
      company: company,
      street: street,
      plz: plz,
      location: country
    )
  end

  it "is not valid without email" do
    person = Person.new()

    expect(person).to_not be_valid
  end

  it "sets name after create or update" do
    person1 = Person.create(email: Faker::Internet.email)
    person2 = Person.create(email: Faker::Internet.email, firstname: Faker::Name.first_name, lastname: Faker::Name.last_name)
    person3 = Person.create(email: Faker::Internet.email, firstname: Faker::Name.first_name)
    person4 = Person.create(email: Faker::Internet.email, lastname: Faker::Name.last_name)

    expect(person1.name == person1.email.split("@").first).to be_true
    expect(person2.name == "#{person2.firstname} #{person2.lastname}").to be_true
    expect(person3.name == person3.email.split("@").first).to be_true
    expect(person4.name == person4.email.split("@").first).to be_true

  end

end
