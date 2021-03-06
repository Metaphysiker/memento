require 'rails_helper'

RSpec.describe "search_people", :type => :feature do

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "searches among 3 people and expects 1 result" do
    unique_lastname = Faker::Name.unique.last_name
    person = Person.create(
      email: Faker::Internet.unique.email,
      firstname: Faker::Name.unique.first_name,
      lastname: unique_lastname,
      description: Faker::Lorem.unique.paragraph,
      phone: Faker::PhoneNumber.unique.cell_phone,
      gender: Person.genders.sample
    )

    person2 = Person.create(
      email: Faker::Internet.unique.email,
      firstname: Faker::Name.unique.first_name,
      lastname: Faker::Name.unique.last_name,
      description: Faker::Lorem.unique.paragraph,
      phone: Faker::PhoneNumber.unique.cell_phone,
      gender: Person.genders.sample
    )
    person3 = Person.create(
      email: Faker::Internet.unique.email,
      firstname: Faker::Name.unique.first_name,
      lastname: Faker::Name.unique.last_name,
      description: Faker::Lorem.unique.paragraph,
      phone: Faker::PhoneNumber.unique.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/"
    #fill_in "#search_people", :with => unique_lastname
    find('#search_inputs_search_term').set(unique_lastname)

    expect(page).to have_content(person.email)
    expect(page).to have_content(person.firstname)
    expect(page).to have_content(person.lastname)
    expect(page).to have_content(person.description)
    expect(page).to have_content(person.phone)

    expect(page).to_not have_content(person2.email)
    expect(page).to_not have_content(person2.firstname)
    expect(page).to_not have_content(person2.lastname)
    expect(page).to_not have_content(person2.description)
    expect(page).to_not have_content(person2.phone)

    expect(page).to_not have_content(person3.email)
    expect(page).to_not have_content(person3.firstname)
    expect(page).to_not have_content(person3.lastname)
    expect(page).to_not have_content(person3.description)
    expect(page).to_not have_content(person3.phone)
  end

  it "searches among 3 people and expects 3 results" do
    unique_lastname = Faker::Name.unique.last_name
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: unique_lastname,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    person2 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: unique_lastname,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )
    person3 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: unique_lastname,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/"
    #fill_in "#search_people", :with => unique_lastname
    find('#search_inputs_search_term').set(unique_lastname)

    expect(page).to have_content(person.email)
    expect(page).to have_content(person.firstname)
    expect(page).to have_content(person.lastname)
    expect(page).to have_content(person.description)
    expect(page).to have_content(person.phone)

    expect(page).to have_content(person2.email)
    expect(page).to have_content(person2.firstname)
    expect(page).to have_content(person2.lastname)
    expect(page).to have_content(person2.description)
    expect(page).to have_content(person2.phone)

    expect(page).to have_content(person3.email)
    expect(page).to have_content(person3.firstname)
    expect(page).to have_content(person3.lastname)
    expect(page).to have_content(person3.description)
    expect(page).to have_content(person3.phone)

  end

  it "searches among 3 people and expects 0 results" do
    unique_lastname = Faker::Name.unique.last_name
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
    #fill_in "#search_people", :with => unique_lastname
    find('#search_inputs_search_term').set(unique_lastname)

    expect(page).to_not have_content(person.email)
    expect(page).to_not have_content(person.firstname)
    expect(page).to_not have_content(person.lastname)
    expect(page).to_not have_content(person.description)
    expect(page).to_not have_content(person.phone)

    expect(page).to_not have_content(person2.email)
    expect(page).to_not have_content(person2.firstname)
    expect(page).to_not have_content(person2.lastname)
    expect(page).to_not have_content(person2.description)
    expect(page).to_not have_content(person2.phone)

    expect(page).to_not have_content(person3.email)
    expect(page).to_not have_content(person3.firstname)
    expect(page).to_not have_content(person3.lastname)
    expect(page).to_not have_content(person3.description)
    expect(page).to_not have_content(person3.phone)

  end

  it "searches with firstname and lastname and expect 1 result" do

    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/"
    #fill_in "#search_people", :with => "#{person.firstname} #{person.lastname}"
    find('#search_inputs_search_term').set("#{person.firstname} #{person.lastname}")

    expect(page).to have_content(person.email)
    expect(page).to have_content(person.firstname)
    expect(page).to have_content(person.lastname)
    expect(page).to have_content(person.description)
    expect(page).to have_content(person.phone)
  end

  it "searches with email and expect 1 result" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/"
    #fill_in "#search_people", :with => person.email
    find('#search_inputs_search_term').set(person.email)

    expect(page).to have_content(person.email)
    expect(page).to have_content(person.firstname)
    expect(page).to have_content(person.lastname)
    expect(page).to have_content(person.description)
    expect(page).to have_content(person.phone)
  end

  it "searches with phone and expect 1 result" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/"
    #fill_in "#search_people", :with => person.phone
    find('#search_inputs_search_term').set(person.phone)

    expect(page).to have_content(person.email)
    expect(page).to have_content(person.firstname)
    expect(page).to have_content(person.lastname)
    expect(page).to have_content(person.description)
    expect(page).to have_content(person.phone)
  end

  it "searches with description and expect 1 result" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/"
    #fill_in "#search_people", :with => person.description
    find('#search_inputs_search_term').set(person.description)

    expect(page).to have_content(person.email)
    expect(page).to have_content(person.firstname)
    expect(page).to have_content(person.lastname)
    expect(page).to have_content(person.description)
    expect(page).to have_content(person.phone)
  end

  it "searches among 3 people and expects 1 result in list-view" do
    unique_lastname = Faker::Name.unique.last_name
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: unique_lastname,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    person2 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.unique.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )
    person3 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.unique.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/"
    find(".list-view").click
    #fill_in "#search_people", :with => unique_lastname
    find('#search_inputs_search_term').set(unique_lastname)

    expect(page).to have_content(person.email)
    expect(page).to have_content(person.firstname)
    expect(page).to have_content(person.lastname)
    expect(page).to_not have_content(person.description)
    expect(page).to have_content(person.phone)

    expect(page).to_not have_content(person2.email)
    expect(page).to_not have_content(person2.firstname)
    expect(page).to_not have_content(person2.lastname)
    expect(page).to_not have_content(person2.description)
    expect(page).to_not have_content(person2.phone)

    expect(page).to_not have_content(person3.email)
    expect(page).to_not have_content(person3.firstname)
    expect(page).to_not have_content(person3.lastname)
    expect(page).to_not have_content(person3.description)
    expect(page).to_not have_content(person3.phone)

  end



end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
