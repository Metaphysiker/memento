require 'rails_helper'

RSpec.describe "institutions", :type => :feature do

  before(:each) do
    30.times do |tag|
      Institution.create(name: Faker::Name.unique.last_name)
    end
  end

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "views a person and expects to see 0 institutions" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    institution1 = Institution.create(name: Faker::Address.community)
    institution2 = Institution.create(name: Faker::Address.community)
    institution3 = Institution.create(name: Faker::Address.community)
    institution4 = Institution.create(name: Faker::Address.community)

    visit "/people/#{person.id}"

    within ".person-#{person.id}-institutions" do
      expect(page).to_not have_content(institution1.name)
      expect(page).to_not have_content(institution2.name)
      expect(page).to_not have_content(institution3.name)
      expect(page).to_not have_content(institution4.name)
    end
  end

  it "views a person and expects to see 1 institution" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    institution1 = Institution.create(name: Faker::Address.community)
    institution2 = Institution.create(name: Faker::Address.community)
    institution3 = Institution.create(name: Faker::Address.community)
    institution4 = Institution.create(name: Faker::Address.community)

    person.institutions << institution1

    visit "/people/#{person.id}"

    within ".person-#{person.id}-institutions" do
      expect(page).to have_content(institution1.name)
      expect(page).to_not have_content(institution2.name)
      expect(page).to_not have_content(institution3.name)
      expect(page).to_not have_content(institution4.name)
    end
  end

  it "views a person and expects to see 3 institutions" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    institution1 = Institution.create(name: Faker::Address.community)
    institution2 = Institution.create(name: Faker::Address.community)
    institution3 = Institution.create(name: Faker::Address.community)
    institution4 = Institution.create(name: Faker::Address.community)

    person.institutions << institution1
    person.institutions << institution2
    person.institutions << institution3

    visit "/people/#{person.id}"

    within ".person-#{person.id}-institutions" do
      expect(page).to have_content(institution1.name)
      expect(page).to have_content(institution2.name)
      expect(page).to have_content(institution3.name)
      expect(page).to_not have_content(institution4.name)
    end
  end

  it "adds an institution to a person" do
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
  end

  it "adds 2 institutions to a person" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )
    institution1 = Institution.create(name: Faker::Address.community)
    institution2 = Institution.create(name: Faker::Address.community)

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click

    select_from_chosen(institution1.name, from: 'person_institution_ids')
    select_from_chosen(institution2.name, from: 'person_institution_ids')

    click_button "Person aktualisieren"

    within ".person-#{person.id}-institutions" do
      expect(page).to have_content(institution1.name)
      expect(page).to have_content(institution2.name)
    end
  end

  it "removes 1 institutions from a person" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )
    institution1 = Institution.create(name: Faker::Address.community)
    institution2 = Institution.create(name: Faker::Address.community)

    person.institutions << institution1
    person.institutions << institution2

    visit "/people/#{person.id}"

    within ".person-#{person.id}-institutions" do
      expect(page).to have_content(institution1.name)
      expect(page).to have_content(institution2.name)
    end

    find(".person-#{person.id}-edit").click

    remove_from_chosen(institution1.name, from: 'person_institution_ids')

    click_button "Person aktualisieren"

    within ".person-#{person.id}-institutions" do
      expect(page).to_not have_content(institution1.name)
      expect(page).to have_content(institution2.name)
    end
  end

  it "removes 2 institutions from a person" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )
    institution1 = Institution.create(name: Faker::Address.community)
    institution2 = Institution.create(name: Faker::Address.community)

    person.institutions << institution1
    person.institutions << institution2

    visit "/people/#{person.id}"

    within ".person-#{person.id}-institutions" do
      expect(page).to have_content(institution1.name)
      expect(page).to have_content(institution2.name)
    end

    find(".person-#{person.id}-edit").click

    remove_from_chosen(institution1.name, from: 'person_institution_ids')
    remove_from_chosen(institution2.name, from: 'person_institution_ids')

    click_button "Person aktualisieren"

    within ".person-#{person.id}-institutions" do
      expect(page).to_not have_content(institution1.name)
      expect(page).to_not have_content(institution2.name)
    end
  end

  it "creates an institution" do

    name = Faker::Address.community
    description = Faker::Lorem.paragraph

    visit "/institutions/"

    click_button "Institution erstellen"

    fill_in "Name", :with => name
    fill_in "Beschreibung", :with => description

    within(".form-actions") do
      click_button "Institution erstellen"
    end

    #page.save_screenshot('create-institution.png')
    expect(page).to have_content(name)
    expect(page).to have_content(description)
  end

  it "updates an institution" do

    name = Faker::Address.community
    description = Faker::Lorem.paragraph

    institution = Institution.create(name: Faker::Address.community, description: Faker::Lorem.paragraph)

      visit "/institutions/#{institution.id}"

      find(".institution-#{institution.id}-edit").click

      fill_in "Name", :with => name
      fill_in "Beschreibung", :with => description

      click_button "Institution aktualisieren"

      expect(page).to_not have_content(institution.name)
      expect(page).to_not have_content(institution.description)

      expect(page).to have_content(name)
      expect(page).to have_content(description)
  end

  it "deletes an institution" do

    name = Faker::Address.community
    description = Faker::Lorem.paragraph
    institution = Institution.create(name: name, description: description)

    visit "/institutions/#{institution.id}"
    find(".institution-#{institution.id}-delete").click
    #page.save_screenshot('delete_institution.png')
    page.evaluate_script('window.confirm = function() { return true; }')
    #expect(institution).to be_nil
    #expect(institution.find(institution.id)).to be_empty
    expect { Institution.find(institution.id)}.to raise_error ActiveRecord::RecordNotFound
  end

  it "adds a function to an institution member" do
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

    visit "/institutions/#{institution1.id}"

    find(".affiliation-#{institution1.affiliations.first.id}-edit").click
    fill_in "Funktion", :with => function
    click_button "Funktion aktualisieren"
    expect(page).to have_content(function)
    #affiliation-#{affiliation.id}-function



  end

end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
