require 'rails_helper'

RSpec.describe "institutions", :type => :feature do

  before(:each) do
    30.times do |tag|
      Institution.create(name: Faker::Address.unique.community)
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

    institution1 = Institution.create(name: Faker::Address.unique.community)
    institution2 = Institution.create(name: Faker::Address.unique.community)
    institution3 = Institution.create(name: Faker::Address.unique.community)
    institution4 = Institution.create(name: Faker::Address.unique.community)

    visit "/people/#{person.id}"

    within ".person-#{person.id}-institutions" do
      expect(page).to_not have_content(institution1.name)
      expect(page).to_not have_content(institution2.name)
      expect(page).to_not have_content(institution3.name)
      expect(page).to_not have_content(institution4.name)
    end
  end

  it "views a person and expects to see 1 institutions" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    institution1 = Institution.create(name: Faker::Address.unique.community)
    institution2 = Institution.create(name: Faker::Address.unique.community)
    institution3 = Institution.create(name: Faker::Address.unique.community)
    institution4 = Institution.create(name: Faker::Address.unique.community)

    person << institution1

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

    institution1 = Institution.create(name: Faker::Address.unique.community)
    institution2 = Institution.create(name: Faker::Address.unique.community)
    institution3 = Institution.create(name: Faker::Address.unique.community)
    institution4 = Institution.create(name: Faker::Address.unique.community)

    person << institution1
    person << institution2
    person << institution3

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
    institution1 = Institution.create(name: Faker::Address.unique.community)

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click

    select_from_chosen(institution1.name, from: 'person_institutions_ids_list')

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
    institution1 = Institution.create(name: Faker::Address.unique.community)
    institution2 = Institution.create(name: Faker::Address.unique.community)

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click

    select_from_chosen(institution1.name, from: 'person_institutions_ids_list')
    select_from_chosen(institution2.name, from: 'person_institutions_ids_list')

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
    institution1 = Institution.create(name: Faker::Address.unique.community)
    institution2 = Institution.create(name: Faker::Address.unique.community)

    person << institution1
    person << institution2

    visit "/people/#{person.id}"

    within ".person-#{person.id}-institutions" do
      expect(page).to have_content(institution1.name)
      expect(page).to have_content(institution2.name)
    end

    find(".person-#{person.id}-edit").click

    remove_from_chosen(institution1.name, from: 'person_institutions_ids_list')

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
    institution1 = Institution.create(name: Faker::Address.unique.community)
    institution2 = Institution.create(name: Faker::Address.unique.community)

    person << institution1
    person << institution2

    visit "/people/#{person.id}"

    within ".person-#{person.id}-institutions" do
      expect(page).to have_content(institution1.name)
      expect(page).to have_content(institution2.name)
    end

    find(".person-#{person.id}-edit").click

    remove_from_chosen(institution1.name, from: 'person_institutions_ids_list')
    remove_from_chosen(institution2.name, from: 'person_institutions_ids_list')

    click_button "Person aktualisieren"

    within ".person-#{person.id}-institutions" do
      expect(page).to_not have_content(institution1.name)
      expect(page).to_not have_content(institution2.name)
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
