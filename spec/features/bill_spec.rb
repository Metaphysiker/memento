require 'rails_helper'

RSpec.describe "bill", :type => :feature do

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "creates a bill for a platin-member" do

    person = Person.create(
      email: Faker::Internet.unique.email,
      firstname: Faker::Name.unique.first_name,
      lastname: Faker::Name.unique.last_name,
      description: Faker::Lorem.unique.paragraph,
      phone: Faker::PhoneNumber.unique.cell_phone,
      gender: Person.genders.sample
    )

    person.address.update(
      line1: Faker::Address.community,
      line2: Faker::HarryPotter.quote,
      line3: Faker::HarryPotter.character,
      line4: Faker::GreekPhilosophers.name,
      line5: Faker::GreekPhilosophers.quote,

      street: Faker::Address.street_address,
      plz: Faker::Address.zip_code,
      location: Faker::Address.city,
    )

    visit "/people/#{person.id}"

    within(".person-#{person.id}") do
      click_link "Rechnung erstellen"
    end

    amount = 80
    membership = "Platinmitglied"

    fill_in "Betrag", :with => amount
    select membership, :from => "Mitgliedschaftsvariante"

  end


end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
