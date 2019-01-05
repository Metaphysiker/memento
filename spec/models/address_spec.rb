require 'rails_helper'

RSpec.describe Address, type: :model do

=begin
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
=end

  it "sets form of address, gender, firstname and lastname in address after create of person" do
    pending
  person = Person.create(
    email: Faker::Internet.email,
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    description: Faker::Lorem.paragraph,
    phone: Faker::PhoneNumber.cell_phone,
    gender: "male"
  )

  expect(person.address.nil?).to be false
  #expect(person.address.firstname == person.firstname).to be true
  #expect(person.address.lastname == person.lastname).to be true
  #expect(person.address.form_of_address == "Herr").to be true

  person2 = Person.create(
    email: Faker::Internet.email,
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    description: Faker::Lorem.paragraph,
    phone: Faker::PhoneNumber.cell_phone,
    gender: "female"
  )

  expect(person2.address.nil?).to be false
  #expect(person2.address.firstname == person2.firstname).to be true
  #expect(person2.address.lastname == person2.lastname).to be true
  #expect(person2.address.form_of_address == "Frau").to be true

  person3 = Person.create(
    email: Faker::Internet.email,
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    description: Faker::Lorem.paragraph,
    phone: Faker::PhoneNumber.cell_phone,
    gender: "transgender"
  )

  expect(person3.address.nil?).to be false
  expect(person3.address.firstname == person3.firstname).to be true
  expect(person3.address.lastname == person3.lastname).to be true
  expect(person3.address.form_of_address.blank?).to be true

  end

  it "it sets company of address after institution-create" do
    institution = Institution.create(name: Faker::Address.community)
    expect(institution.address.nil?).to be false
    expect(institution.address.company == institution.name).to be true
  end

end
