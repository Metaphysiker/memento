require 'rails_helper'

RSpec.describe "notes", :type => :feature do

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  let(:institution) do
     Institution.create(name: Faker::Address.community, description: Faker::Lorem.paragraph)
  end

  it "views a person and expects a note" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    note1 = Note.create(
      description: Faker::Lorem.paragraph
    )

    person.notes << note1
    person.save

    visit "/people/#{person.id}"

    expect(page).to have_content("Notizen anzeigen")

    click_link "Notizen anzeigen"

    within ".person-#{person.id}-notes" do
      expect(page).to have_content(note1.description)
    end

  end

  it "views a person and adds note" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    description = Faker::Lorem.paragraph

    visit "/people/#{person.id}"

    expect(page).to have_content("Notizen anzeigen")

    click_link "Notizen anzeigen"

    within ".person-#{person.id}-notes" do
      expect(page).to have_content("Keine Notizen vorhanden.")
    end

    expect(page).to have_css(".person-#{person.id}-notes-new")

    within ".person-#{person.id}-notes-new" do
      fill_in "Beschreibung", :with => description
      click_button "Notiz erstellen"
    end

    within ".person-#{person.id}-notes" do
      expect(page).to have_content(description)
    end

  end

  it "views a person and adds a second note" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    note1 = Note.create(
      description: Faker::Lorem.paragraph
    )

    person.notes << note1
    person.save

    description = Faker::Lorem.paragraph

    visit "/people/#{person.id}"

    expect(page).to have_content("Notizen anzeigen")

    click_link "Notizen anzeigen"

    within ".person-#{person.id}-notes" do
      expect(page).to have_content(note1.description)
    end

    expect(page).to have_css(".person-#{person.id}-notes-new")

    within ".person-#{person.id}-notes-new" do
      fill_in "Beschreibung", :with => description
      click_button "Notiz erstellen"
    end

    within ".person-#{person.id}-notes" do
      expect(page).to have_content(notes1.description)
      expect(page).to have_content(description)
    end

  end

  it "views a person and deletes a note" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )

    note1 = Note.create(
      description: Faker::Lorem.paragraph
    )

    person.notes << note1
    person.save

    visit "/people/#{person.id}"

    expect(page).to have_content("Notizen anzeigen")

    click_link "Notizen anzeigen"

    within ".person-#{person.id}-notes" do
      expect(page).to have_content(note1.description)
    end

    find(".note-#{note1.id}-delete").click

    page.evaluate_script('window.confirm = function() { return true; }')

    expect { Note.find(note1.id)}.to raise_error ActiveRecord::RecordNotFound

    within ".person-#{person.id}-notes" do
      expect(page).to_not have_content(notes1.description)
    end

  end

  it "views an institution and expects a note" do

    note1 = Note.create(
      description: Faker::Lorem.paragraph
    )

    institution.notes << note1
    institution.save

    visit "/institutions/#{institution.id}"

    expect(page).to have_content("Notizen anzeigen")

    click_link "Notizen anzeigen"

    within ".institution-#{institution.id}-notes" do
      expect(page).to have_content(note1.description)
    end

  end

  it "views a institution and adds note" do

    description = Faker::Lorem.paragraph

    visit "/institutions/#{institution.id}"

    expect(page).to have_content("Notizen anzeigen")

    click_link "Notizen anzeigen"

    within ".institution-#{institution.id}-notes" do
      expect(page).to have_content("Keine Notizen vorhanden.")
    end

    expect(page).to have_css(".institution-#{institution.id}-notes-new")

    within ".institution-#{institution.id}-notes-new" do
      fill_in "Beschreibung", :with => description
      click_button "Notiz erstellen"
    end

    within ".institution-#{institution.id}-notes" do
      expect(page).to have_content(description)
    end

  end

  it "views a institution and adds a second note" do

    note1 = Note.create(
      description: Faker::Lorem.paragraph
    )

    institution.notes << note1
    institution.save

    description = Faker::Lorem.paragraph

    visit "/institutions/#{institution.id}"

    expect(page).to have_content("Notizen anzeigen")

    click_link "Notizen anzeigen"

    within ".institution-#{institution.id}-notes" do
      expect(page).to have_content(note1.description)
    end

    expect(page).to have_css(".institution-#{institution.id}-notes-new")

    within ".institution-#{institution.id}-notes-new" do
      fill_in "Beschreibung", :with => description
      click_button "Notiz erstellen"
    end

    within ".institution-#{institution.id}-notes" do
      expect(page).to have_content(notes1.description)
      expect(page).to have_content(description)
    end

  end

  it "views a institution and deletes a note" do

    note1 = Note.create(
      description: Faker::Lorem.paragraph
    )

    institution.notes << note1
    institution.save

    visit "/institutions/#{institution.id}"

    expect(page).to have_content("Notizen anzeigen")

    click_link "Notizen anzeigen"

    within ".institution-#{institution.id}-notes" do
      expect(page).to have_content(note1.description)
    end

    find(".note-#{note1.id}-delete").click

    page.evaluate_script('window.confirm = function() { return true; }')

    expect { Note.find(note1.id)}.to raise_error ActiveRecord::RecordNotFound

    within ".institution-#{institution.id}-notes" do
      expect(page).to_not have_content(notes1.description)
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
