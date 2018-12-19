require 'rails_helper'

RSpec.describe "affiliations", :type => :feature do

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "views a person and expects to see an affiliation" do
    person1 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    institution1 = Institution.create(name: Faker::Address.community)

    function = "Präsident der Organisation"

    affiliation1 = Affiliation.create(institution_id: institution1.id, person_id: person1.id, function: function)

    visit "/people/#{person1.id}"
    expect(page).to have_content(function)

  end

  it "views a person and adds an affiliation" do
    person1 = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: Person.genders.sample
    )

    institution1 = Institution.create(name: Faker::Address.community)

    function = "Präsident der Organisation"

    affiliation1 = Affiliation.create(institution_id: institution1.id, person_id: person1.id)

    visit "/people/#{person1.id}"
    expect(page).to have_css(".affiliation-#{affiliation1.id}")
    find(".affiliation-#{affiliation1.id}-edit").click
    find(".affiliation-#{affiliation1.id}-function").set(function)
    click_button "Funktion aktualisieren"
    expect(page).to have_css(".affiliation-#{affiliation1.id}", text: function)

  end

end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
