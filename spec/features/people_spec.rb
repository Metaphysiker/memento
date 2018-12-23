require 'rails_helper'

RSpec.describe "people", :type => :feature do

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "displays a person's information" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample,
      website: Faker::Internet.url
    )

    visit "/people/#{person.id}"
    expect(page).to have_content(person.email)
    expect(page).to have_content("e-Mail:")
    expect(page).to have_content(person.firstname)
    expect(page).to have_content(person.lastname)
    expect(page).to have_css(".person-name", text: person.firstname)
    expect(page).to have_css(".person-name", text: person.lastname)
    expect(page).to have_content(person.description)
    expect(page).to have_content(person.phone)
    expect(page).to have_content("Telefon:")
    expect(page).to have_content(I18n.t(person.gender))
    expect(page).to have_content("Geschlecht:")
    expect(page).to have_content(person.website)
    expect(page).to have_content("Webseite:")

  end

  it "displays a person's information with no first and lastname" do
    person = Person.create(
      email: Faker::Internet.email,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/#{person.id}"
    expect(page).to have_content(person.email)
    expect(page).to have_content("e-Mail:")
    expect(page).to have_css(".person-name", text: person.email.split("@").first)
    expect(page).to have_content(person.description)
    expect(page).to have_content(person.phone)
    expect(page).to have_content("Telefon:")
    expect(page).to have_content(I18n.t(person.gender))
    expect(page).to have_content("Geschlecht:")
  end

  it "deletes a person" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/#{person.id}"
    find(".person-#{person.id}-delete").click
    #page.save_screenshot('delete_person.png')
    page.evaluate_script('window.confirm = function() { return true; }')
    #expect(person).to be_nil
    #expect(Person.find(person.id)).to be_empty
    expect { Person.find(person.id)}.to raise_error ActiveRecord::RecordNotFound

  end

  it "updates and displays person's information" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male",
      website: Faker::Internet.url
    )

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click

    firstname = Faker::Name.unique.first_name
    lastname = Faker::Name.unique.last_name
    description = Faker::Lorem.unique.paragraph
    email = Faker::Internet.unique.email
    phone = Faker::PhoneNumber.unique.cell_phone
    website = Faker::Internet.unique.url

    fill_in "Vorname", :with => firstname
    fill_in "Nachname", :with => lastname
    fill_in "Beschreibung", :with => description
    fill_in "e-Mail", :with => email
    fill_in "Telefon", :with => phone
    select(I18n.t("female"), :from => 'Geschlecht')
    fill_in "Webseite", :with => website

    click_button "Person aktualisieren"

    expect(page).to_not have_content(person.email)
    expect(page).to_not have_content(person.firstname)
    expect(page).to_not have_content(person.lastname)
    expect(page).to_not have_content(person.description)
    expect(page).to_not have_content(person.phone)
    expect(page).to_not have_content(I18n.t("male"))

    expect(page).to have_content(email)
    expect(page).to have_content(firstname)
    expect(page).to have_content(lastname)
    expect(page).to have_content(description)
    expect(page).to have_content(phone)
    expect(page).to have_content(I18n.t("female"))
  end

  it "updates and leaves email blank which should re-render edit" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click

    fill_in "e-Mail", :with => ""

    click_button "Person aktualisieren"

    expect(page).to have_content("e-Mail muss ausgefüllt werden")

  end

  it "enters a used email-adress and updates which should re-render edit" do
    person = Person.create(
      email: Faker::Internet.email
    )

    person2 = Person.create(
      email: Faker::Internet.email
    )

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click

    fill_in "e-Mail", :with => person2.email

    click_button "Person aktualisieren"

    expect(page).to have_content("e-Mail ist bereits vergeben")

  end

  it "updates and displays person's information in index" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    person2 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )
    person3 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/"
    find(".person-#{person.id}-edit").click

    firstname = Faker::Name.unique.first_name
    lastname = Faker::Name.unique.last_name
    description = Faker::Lorem.unique.paragraph
    email = Faker::Internet.unique.email
    phone = Faker::PhoneNumber.unique.cell_phone

    fill_in "Vorname", :with => firstname
    fill_in "Nachname", :with => lastname
    fill_in "Beschreibung", :with => description
    fill_in "e-Mail", :with => email
    fill_in "Telefon", :with => phone

    click_button "Person aktualisieren"

    expect(page).to_not have_content(person.email)
    expect(page).to_not have_content(person.firstname)
    expect(page).to_not have_content(person.lastname)
    expect(page).to_not have_content(person.description)
    expect(page).to_not have_content(person.phone)

    expect(page).to have_content(email)
    expect(page).to have_content(firstname)
    expect(page).to have_content(lastname)
    expect(page).to have_content(description)
    expect(page).to have_content(phone)
  end

  it "updates and displays person's information in index in list view" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    person2 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )
    person3 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/"
    find(".list-view").click
    find(".person-#{person.id}-edit").click
    firstname = Faker::Name.unique.first_name
    lastname = Faker::Name.unique.last_name
    description = Faker::Lorem.unique.paragraph
    email = Faker::Internet.unique.email
    phone = Faker::PhoneNumber.unique.cell_phone

    fill_in "Vorname", :with => firstname
    fill_in "Nachname", :with => lastname
    fill_in "Beschreibung", :with => description
    fill_in "e-Mail", :with => email
    fill_in "Telefon", :with => phone

    click_button "Person aktualisieren"

    expect(page).to_not have_content(person.email)
    expect(page).to_not have_content(person.firstname)
    expect(page).to_not have_content(person.lastname)
    expect(page).to_not have_content(person.description)
    expect(page).to_not have_content(person.phone)

    expect(page).to have_content(email)
    expect(page).to have_content(firstname)
    expect(page).to have_content(lastname)
    expect(page).to_not have_content(description)
    expect(page).to have_content(phone)
  end

  it "deletes a person in index in list view" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    person2 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )
    person3 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/"
    find(".list-view").click
    find(".person-#{person.id}-delete").click

    expect(page).to_not have_content(person.email)
    expect(page).to_not have_content(person.firstname)
    expect(page).to_not have_content(person.lastname)
    expect(page).to_not have_content(person.description)
    expect(page).to_not have_content(person.phone)
  end

  it "creates a person" do
    visit "/people/"
    click_button "Person erstellen"

    firstname = Faker::Name.first_name
    lastname = Faker::Name.last_name
    description = Faker::Lorem.paragraph
    email = Faker::Internet.email
    phone = Faker::PhoneNumber.cell_phone

    fill_in "Vorname", :with => firstname
    fill_in "Nachname", :with => lastname
    fill_in "Beschreibung", :with => description
    fill_in "e-Mail", :with => email
    fill_in "Telefon", :with => phone

    within(".form-actions") do
      click_button "Person erstellen"
    end

    expect(page).to have_content(email)
    expect(page).to have_content(firstname)
    expect(page).to have_content(lastname)
    expect(page).to have_content(description)
    expect(page).to have_content(phone)
  end

  it "expects language" do
    person = Person.create(
      email: Faker::Internet.email,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample,
      language: Rails.configuration.language.sample
    )

    visit "/people/#{person.id}"
    expect(page).to have_content("Sprache:")
    expect(page).to have_content(I18n.t(person.language))
  end

  it "updates and expects language" do
    person = Person.create(
      email: Faker::Internet.email,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    language = Rails.configuration.language.sample

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click

    select(I18n.t(language), :from => 'Sprache')

    click_button "Person aktualisieren"

    expect(page).to have_content("Sprache:")
    expect(page).to have_content(I18n.t(language))
  end

  it "adds a function to member from person view" do
    function = "Präsident"

    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    institution1 = Institution.create(name: Faker::Address.community)

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click

    select_from_chosen(institution1.name, from: 'person_institution_ids')

    click_button "Person aktualisieren"

    within ".person-#{person.id}-institutions" do
      expect(page).to have_content(institution1.name)
    end

    visit "/people/#{person.id}"

    find(".affiliation-#{person.affiliations.first.id}-edit").click
    fill_in "Funktion", :with => function
    click_button "Funktion aktualisieren"
    expect(page).to have_content(function)
  end

  it "creates two people with male and female names and expects gender accordingly" do
    person1 = Person.create(
      email: Faker::Internet.email,
      firstname: "Stefan",
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone
    )

    person2 = Person.create(
      email: Faker::Internet.email,
      firstname: "Leonie",
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone
    )

    visit "/people/#{person1.id}"
    expect(page).to have_content(I18n.t("male"))

    visit "/people/#{person2.id}"
    expect(page).to have_content(I18n.t("female"))

  end

end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
