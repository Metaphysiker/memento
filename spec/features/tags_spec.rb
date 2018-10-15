require 'rails_helper'

RSpec.describe "tags", :type => :feature do

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "views a male person and expects an address" do
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

    within ".address-#{person.address.id}" do
      expect(page).to have_content("Herr")
      expect(page).to have_content(person.firstname)
      expect(page).to have_content(person.lastname)
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