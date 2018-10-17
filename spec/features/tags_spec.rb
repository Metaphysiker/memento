require 'rails_helper'

RSpec.describe "tags", :type => :feature do

  before(:all) do
    10.times do
      Tag.create(name: Faker::Lorem.word)
    end
  end

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

    tag1 = Tag.first
    person.tag_list.add(tag1)

    tag2 = Tag.second
    person.tag_list.add(tag2)

    visit "/people/#{person.id}"

    within ".person-#{person.id}-tags" do
      expect(page).to have_content(tag1)
      expect(page).to have_content(tag2)
    end

  end

  it "views a person, adds tags and expects tags" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )
    tag1 = Tag.first

    tag2 = Tag.second

    visit "/people/#{person.id}"

    find(".person-#{person.id}-edit").click

    page.save_screenshot('tag-add-1')

    select(tag1, :from => 'Tags')
    select(tag2, :from => 'Tags')

    page.save_screenshot('tag-add-2')

    click_button "Person aktualisieren"

    within ".person-#{person.id}-tags" do
      expect(page).to have_content(tag1)
      expect(page).to have_content(tag2)
    end

  end

  it "views a person, remove tags and expects no tags" do
    person = Person.create(
      email: Faker::Internet.email,
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      description: Faker::Lorem.paragraph,
      phone: Faker::PhoneNumber.cell_phone,
      gender: "male"
    )
    tag1 = Tag.first
    person.tag_list.add(tag1)

    tag2 = Tag.second
    person.tag_list.add(tag2)

    visit "/people/#{person.id}"

    within ".person-#{person.id}-tags" do
      expect(page).to have_content(tag1)
      expect(page).to have_content(tag2)
    end

    find(".person-#{person.id}-edit").click

    fill_in "Tags", with: ""

    click_button "Person aktualisieren"

    within ".person-#{person.id}-tags" do
      expect(page).to_not have_content(tag1)
      expect(page).to_not have_content(tag2)
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
