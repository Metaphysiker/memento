require 'rails_helper'

RSpec.describe "address", :type => :feature do

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "views a male person and expects an address" do
    person = Person.create(
      form_of_address: "Prof. Dr.",
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    visit "/people/#{person.id}"

    expect(page).to have_content("Adresse anzeigen")

    click_link "Adresse anzeigen"

    within ".address-#{person.address.id}" do
      expect(page).to have_content("Prof. Dr.")
      expect(page).to have_content(person.firstname)
      expect(page).to have_content(person.lastname)
    end

  end

  it "views a female person and expects an address" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "female"
    )

    visit "/people/#{person.id}"

    expect(page).to have_content("Adresse anzeigen")

    click_link "Adresse anzeigen"

    within ".address-#{person.address.id}" do
      #expect(page).to have_content("Frau")
      expect(page).to have_content(person.firstname)
      expect(page).to have_content(person.lastname)
    end

  end

  it "views a person, adds an address and expects address" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    visit "/people/#{person.id}"

    expect(page).to have_content("Adresse anzeigen")

    click_link "Adresse anzeigen"

    find(".address-#{person.address.id}-edit").click

    line1 = Faker::Address.community
    line2 = Faker::HarryPotter.quote
    line3 = Faker::HarryPotter.character
    line4 = Faker::GreekPhilosophers.name
    line5 = Faker::GreekPhilosophers.quote

    street = Faker::Address.street_address
    plz = Faker::Address.zip_code
    location = Faker::Address.city
    country = "Schweiz"

    #fill_in "Anrede", :with => "Herr Dr."
    #fill_in "Vorname", :with => person.firstname
    #fill_in "Nachname", :with => person.lastname
    fill_in "Erste Zeile", :with => line1
    fill_in "Zweite Zeile", :with => line2
    fill_in "Dritte Zeile", :with => line3
    fill_in "Vierte Zeile", :with => line4
    fill_in "Fünfte Zeile", :with => line5
    fill_in "Strasse", :with => street
    fill_in "PLZ", :with => plz
    fill_in "Ort", :with => location
    select(country, :from => 'Land')

    click_button "Adresse aktualisieren"

    within ".address-#{person.address.id}" do
      #expect(page).to have_content("Herr Dr.")
      #expect(page).to have_content(person.firstname)
      #expect(page).to have_content(person.lastname)
      expect(page).to have_content(line1)
      expect(page).to have_content(line2)
      expect(page).to have_content(line3)
      expect(page).to have_content(line4)
      expect(page).to have_content(line5)
      expect(page).to have_content(street)
      expect(page).to have_content(plz)
      expect(page).to have_content(location)
      expect(page).to_not have_content("Schweiz")
    end
  end

  it "views a person, adds an address in Germany and expects address" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "female"
    )

    visit "/people/#{person.id}"

    expect(page).to have_content("Adresse anzeigen")

    click_link "Adresse anzeigen"

    find(".address-#{person.address.id}-edit").click

    line1 = Faker::Address.community
    street = Faker::Address.street_address
    plz = Faker::Address.zip_code
    location = Faker::Address.city
    country = "Deutschland"

#    fill_in "Vorname", :with => person.firstname
#    fill_in "Nachname", :with => person.lastname
    fill_in "Erste Zeile", :with => line1
    fill_in "Strasse", :with => street
    fill_in "PLZ", :with => plz
    fill_in "Ort", :with => location
    select(country, :from => 'Land')

    click_button "Adresse aktualisieren"

    within ".address-#{person.address.id}" do
      #expect(page).to have_content("Frau")
      expect(page).to have_content(person.firstname)
      expect(page).to have_content(person.lastname)
      expect(page).to have_content(line1)
      expect(page).to have_content(street)
      expect(page).to have_content(plz)
      expect(page).to have_content(location)
      expect(page).to have_content("Deutschland")
    end
  end

  it "views a person, adds an address and expects address in profiles-view" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    person2 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    person3 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    visit "/people/"

    within ".person-#{person.id}" do
      expect(page).to have_content("Adresse anzeigen")

      click_link "Adresse anzeigen"
    end

    find(".address-#{person.address.id}-edit").click

    line1 = Faker::Address.community
    street = Faker::Address.street_address
    plz = Faker::Address.zip_code
    location = Faker::Address.city
    country = "Schweiz"

    #fill_in "Anrede", :with => "Herr Dr."
    #fill_in "Vorname", :with => person.firstname
    #fill_in "Nachname", :with => person.lastname
    fill_in "Erste Zeile", :with => line1
    fill_in "Strasse", :with => street
    fill_in "PLZ", :with => plz
    fill_in "Ort", :with => location
    select(country, :from => 'Land')

    click_button "Adresse aktualisieren"

    within ".address-#{person.address.id}" do
      #expect(page).to have_content("Herr Dr.")
      expect(page).to have_content(person.firstname)
      expect(page).to have_content(person.lastname)
      expect(page).to have_content(line1)
      expect(page).to have_content(street)
      expect(page).to have_content(plz)
      expect(page).to have_content(location)
      expect(page).to_not have_content("Schweiz")
    end
  end

  it "views an institution, adds an address and expects address" do

    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    name = Faker::Address.community
    description = Faker::Lorem.paragraph
    institution = Institution.create(name: name, description: description)

    visit "/institutions/#{institution.id}"

    expect(page).to have_content("Adresse anzeigen")

    click_link "Adresse anzeigen"

    find(".address-#{institution.address.id}-edit").click

    line1 = Faker::Address.community
    street = Faker::Address.street_address
    plz = Faker::Address.zip_code
    location = Faker::Address.city
    country = "Schweiz"

    #fill_in "Anrede", :with => "Herr"
    #fill_in "Vorname", :with => person.firstname
    #fill_in "Nachname", :with => person.lastname
    fill_in "Erste Zeile", :with => line1
    fill_in "Strasse", :with => street
    fill_in "PLZ", :with => plz
    fill_in "Ort", :with => location
    select(country, :from => 'Land')

    click_button "Adresse aktualisieren"

    within ".address-#{institution.address.id}" do
      #expect(page).to have_content("Herr")
      #expect(page).to have_content(person.firstname)
      #expect(page).to have_content(person.lastname)
      expect(page).to have_content(line1)
      expect(page).to have_content(street)
      expect(page).to have_content(plz)
      expect(page).to have_content(location)
      expect(page).to_not have_content("Schweiz")
    end
  end


end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
