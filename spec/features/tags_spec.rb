require 'rails_helper'

RSpec.describe "tags", :type => :feature do

  before(:each) do
    first_user = User.create!(:username => Faker::Internet.username, :role => "admin", :email => Faker::Internet.email, :password => "secret")
    login_with(first_user)
  end

  it "views a person and expects tags" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )
    tag1 = Faker::Lorem.word
    person.tag_list.add(tag1)

    tag2 = Faker::Lorem.word
    person.tag_list.add(tag2)

    visit "/people/#{person.id}"

    expect(page).to have_content(tag1)
    expect(page).to have_content(tag2)

  end

  it "views a person, adds tags and expects tags" do
    pending
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )
    tag1 = Faker::Lorem.word
    person.tag_list.add(tag1)

    tag2 = Faker::Lorem.word
    person.tag_list.add(tag2)

    visit "/people/#{person.id}"

    expect(page).to have_content(tag1)
    expect(page).to have_content(tag2)

  end

end

def login_with(user)
  visit "/users/sign_in"
  fill_in "Login", :with => user.username
  fill_in "Passwort", :with => "secret"
  click_button "Log in"

  expect(page).to have_selector(".navbar-brand", :text => user.username)
end
