require 'rails_helper'

RSpec.describe "people", :type => :feature do

  before(:each) do
    first_user = user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "displays person's information" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/#{person.id}"
    expect(page).to have_content(person.email)
    expect(page).to have_content(person.firstname)
    expect(page).to have_content(person.lastname)
    expect(page).to have_content(person.description)
    expect(page).to have_content(person.phone)
    expect(page).to have_content(person.gender)

  end

  it "updates and displays person's information" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    visit "/people/#{person.id}"
    expect(page).to have_content(person.email)
    expect(page).to have_content(person.firstname)
    expect(page).to have_content(person.lastname)
    expect(page).to have_content(person.description)
    expect(page).to have_content(person.phone)
    expect(page).to have_content(person.gender)

  end

end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
